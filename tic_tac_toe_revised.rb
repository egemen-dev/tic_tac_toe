# frozen_string_literal: true

module TicTacToe
  # Game board and its methods.
  class Board
    attr_accessor :cells, :is_on

    WALLS = '--+---+--'

    # Indexes of possible win scenarios.
    POSSIBLE_WINS = [
      [1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7],
      [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]
    ]

    def initialize
      @cells = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    end

    def available
      cells.select { |i| i.instance_of?(Integer) }
    end

    def show
      puts "
      #{cells[0]} | #{cells[1]} | #{cells[2]}
      #{WALLS}
      #{cells[3]} | #{cells[4]} | #{cells[5]}
      #{WALLS}
      #{cells[6]} | #{cells[7]} | #{cells[8]}
      "
    end

    def doable?(num)
      p cells[num - 1] == num
    end

    def move(num, symbol)
      cells[num - 1] = symbol
    end

    # Replaces indexes with given symbol.
    def update(num, symbol)
      POSSIBLE_WINS.each do |scenario|
        scenario[0] == num ? scenario[0] = symbol : scenario[0]
        scenario[1] == num ? scenario[1] = symbol : scenario[1]
        scenario[2] == num ? scenario[2] = symbol : scenario[2]
      end
      POSSIBLE_WINS
    end

    def win?(symbol)
      POSSIBLE_WINS.any?([symbol, symbol, symbol])
    end

    def full?
      if cells.all? { |place| place.instance_of?(String) }
        puts 'Board is full.'
        true
      end
    end

    def no_wins?
      !win?('X') && !win?('O') ? true : false
    end

    def on?
      !full? && no_wins? ? true : false
    end

    # AI evaluates the possibilities of you winning and acts accordingly.
    def ai_select
      x_x = POSSIBLE_WINS.select { |i| i.count('X') == 2 && !i.include?('O') }
      o_o = POSSIBLE_WINS.select { |i| i.count('O') == 2 && !i.include?('X') }
      one_x = POSSIBLE_WINS.select { |i| i.count('X') == 1 && !i.include?('O') }
      one_o = POSSIBLE_WINS.select { |i| i.count('O') == 1 }
      no_x = POSSIBLE_WINS.reject { |i| i.include?('X') }
      no_o = POSSIBLE_WINS.reject { |i| i.include?('O') }

      if x_x.length >= 1
        options = x_x.sample.select { |i| i.instance_of?(Integer) }
      elsif one_x.length >= 1
        options = one_x.sample.select { |i| i.instance_of?(Integer) }
      elsif o_o >= 1
        options = o_o.sample.select { |i| i.instance_of?(Integer) }
      else
        options = no_x.sample.select { |i| i.instance_of?(Integer) }
      end
      options.sample
    end
  end

  # Creation of the player and computer with game-play methods.
  class Game < Board
    attr_reader :name, :symbol, :board, :computer_name, :computer_symbol

    def initialize(name)
      @board = Board.new
      @name = name
      @symbol = 'X'
      @computer_name = 'AI'
      @computer_symbol = 'O'
    end

    def computer_play
      if board.on?
        selection = ai_select
        board.move(selection, computer_symbol)
        board.update(selection, computer_symbol)
        puts "#{computer_name} played for #{selection}"
        puts "#{computer_name} has won the game." if win?(computer_symbol)
        board.show
      end
    end

    def play(num)
      if board.doable?(num) && board.on?
        board.move(num, symbol)
        board.update(num, symbol)
        board.win?(symbol)
        puts "#{name.upcase} you are the winner." if win?(symbol)
        board.show
        computer_play
      end
    end
  end
end

# Main logic, makes the game playable.
def play_now
  include TicTacToe
  puts '▼ Enter your name: '
  name = gets.chomp
  game = Game.new(name)
  game.board.show
  while game.board.on?
    puts "Where do you wanna place the 'X'?"
    num = gets.to_i
    game.play(num)
    game.board.on?
  end
end

play_now
