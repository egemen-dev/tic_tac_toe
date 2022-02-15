# frozen_string_literal: true

BOARD_WALLS = "\n--+---+--\n"
NONNUMERICAL = ['', '+', '-', ' '].freeze
GAME_BOARD = [" \n1 | 2 | 3#{BOARD_WALLS}4 | 5 | 6#{BOARD_WALLS}7 | 8 | 9 \n "].freeze

TOP_ROW = [2, 6, 10]
MID_ROW = [22, 26, 30]
RIGHT_ROW = [42, 46, 50]
LEFT_COL = [2, 22, 42]
MID_COL = [6, 26, 46]
RIGHT_COL = [10, 30, 50]
CROSS_1 = [2, 26, 50]
CROSS_2 = [10, 26, 42]
POSSIBLE_WINS = [TOP_ROW, MID_ROW, RIGHT_ROW, LEFT_COL, MID_COL, RIGHT_COL, CROSS_1, CROSS_2]

# A module for checking possible win senarios.
module BoardCheck
  def possible_wins
    POSSIBLE_WINS.each { |beam| (beam.map! { |i| board[0][i] }) }
  end

  def update(choice, symbol)
    POSSIBLE_WINS.each do |beam|
      index_to_change = beam.index(choice.to_s)
      if index_to_change != nil
        beam[index_to_change] = symbol
      end
    end
    p POSSIBLE_WINS
  end

  def any_possible_wins?(symbol)
    p POSSIBLE_WINS.one?([symbol, symbol, symbol]) ? true : false
    p POSSIBLE_WINS.each do |beam|
      if beam == [[symbol, symbol, symbol]]
        p POSSIBLE_WINS.index(beam)
      end
    end
  end

  def board_check_for(symbol)
    POSSIBLE_WINS.each do |beam|
      beam == [symbol, symbol, symbol]
    end
  end
end

# A module for game-play methods.
module GameMethods
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
    "(#{choice}) is not available for #{symbol}!"
  end
end

# Main game logic.
class TikTacToe
  include GameMethods
  include BoardCheck

  attr_accessor :board, :p1, :p2

  def initialize(first_player, second_player)
    @p1 = first_player
    @p2 = second_player
    @board = GAME_BOARD
    possible_wins
  end

  def player1(choice)
    position_check_n_play(choice, 'X')
  end

  def player2(choice)
    position_check_n_play(choice, 'O')
  end

  private

  def position_check_n_play(choice, symbol)
    if possible?(choice)
      play_at(choice, symbol)
      update(choice, symbol)
      any_possible_wins?(symbol)
      puts board
    else
      show_not_available(choice, symbol)
    end
  end
end

game = TikTacToe.new('abc', 'cef')
puts game.player1(1)
puts game.player1(4)
puts game.player1(7)
puts game.player2(7)

# puts game.position_check(4,"X")
