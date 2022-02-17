BOARD_WALLS = "\n--+---+--\n"
NONNUMERICAL = ['', '+', '-', ' '].freeze
GAME_BOARD = [" \n1 | 2 | 3#{BOARD_WALLS}4 | 5 | 6#{BOARD_WALLS}7 | 8 | 9 \n "]

TOP_ROW = [2, 6, 10]
MID_ROW = [22, 26, 30]
BOT_ROW = [42, 46, 50]
LEFT_COL = [2, 22, 42]
MID_COL = [6, 26, 46]
RIGHT_COL = [10, 30, 50]
CROSS_1 = [2, 26, 50]
CROSS_2 = [10, 26, 42]
POSSIBLE_WINS = [TOP_ROW, MID_ROW, BOT_ROW, LEFT_COL, MID_COL, RIGHT_COL, CROSS_1, CROSS_2]
POSSIBLE_WINS_NAMES = ['TOP ROW', 'MID ROW', 'BOT ROW', 'LEFT COL', 'MID COL', 'RIGHT COL', 'CROSS 1', 'CROSS 2']

# A module for checking possible win scenarios.
module WinCheckMethods
  protected

  def activate_possible_wins
    POSSIBLE_WINS.each { |beam| (beam.map! { |i| board[0][i] }) }
  end

  def update(choice, symbol)
    POSSIBLE_WINS.each do |beam|
      index_to_change = beam.index(choice.to_s)
      unless index_to_change.nil?
        beam[index_to_change] = symbol
        POSSIBLE_WINS.index(beam)
      end
    end
  end

  def any_possible_wins?(symbol)
    POSSIBLE_WINS.each do |beam|
      next unless beam == [symbol, symbol, symbol]

      win_index = POSSIBLE_WINS.index(beam)
      win_place = POSSIBLE_WINS_NAMES[win_index]
      declare_winner(symbol, win_place)
    end
  end

  def declare_winner(symbol, win_place)
    if symbol == 'X'
      puts "\n● #{win_place} is done!\n\n▷ #{p1.upcase} is the winner!\n"
    elsif symbol == 'O'
      puts "\n● #{win_place} is done!\n\n▷ #{p2.upcase} is the winner!\n"
    end
    @is_on = false
  end

  def no_winner
    puts "It's a tie! None beats the other."
    @is_on = false
  end
end

# A module for game-play methods.
module PlacementMethods
  protected

  def play_at(choice, symbol)
    index = board[0].index(choice.to_s)
    board[0][index] = symbol.to_s
  end

  def possible?(choice)
    if board[0].include?(choice.to_s) && NONNUMERICAL.none?(choice.to_s)
      true
    else
      false
    end
  end

  def show_not_available(choice, symbol)
    "(#{choice}) is not available for #{symbol}! You lost your turn haha."
  end
end

# Main game with external methods mixed-in.
class TikTacToe
  include PlacementMethods
  include WinCheckMethods

  attr_accessor :board, :p1, :p2, :is_on, :round

  def initialize(first_player, second_player)
    @p1 = first_player
    @p2 = second_player
    @round = 0
    @is_on = true
    @board = GAME_BOARD
    activate_possible_wins
  end

  def player1(choice)
    position_check_n_play(choice, 'X')
  end

  def player2(choice)
    position_check_n_play(choice, 'O')
  end

  private

  def position_check_n_play(choice, symbol)
    if possible?(choice) && round < 9
      play_at(choice, symbol)
      update(choice, symbol)
      any_possible_wins?(symbol)
      @round += 1
      puts board
    else
      round > 8 ? no_winner : show_not_available(choice, symbol)
    end
  end
end

def player1_action(name1, game)
  puts "#{name1} where do you wanna place your sign 'X': "
  p1_move = gets.chomp
  puts game.player1(p1_move)
end

def player2_action(name2, game)
  puts "#{name2} where do you wanna place your sign 'O': "
  p2_move = gets.chomp
  puts game.player2(p2_move)
end

def start_the_game
  puts '▼ Enter player 1 name: '
  name1 = gets.chomp
  puts '▼ Enter player 2 name: '
  name2 = gets.chomp
  game = TikTacToe.new(name1, name2)
  puts game.board
  while game.is_on
    player1_action(name1, game)
    game.is_on ? player2_action(name2, game) : next
  end
end

start_the_game
