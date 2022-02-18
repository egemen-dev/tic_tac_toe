module TikTacToe
  class Board
    attr_reader :cells

    WALLS = '--+---+--'

    # Indexes of possible win scenarios.
    POSSIBLE_WINS = [
      [1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7],
      [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]
    ]

    def initialize
      @cells = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    end

    def show
      "
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
      p POSSIBLE_WINS
    end

    def win?(symbol)
      p POSSIBLE_WINS.any?([symbol, symbol, symbol])
    end

    def full?
      p cells.all? { |place| place.class == String }
    end
  end
end


include TikTacToe
board = Board.new
puts board.show

# board.doable?(3)
# board.move(3, "X")
# board.update(3, "X")
# board.win?("X")
# board.full?
# puts board.show

# board.doable?(5)
# board.move(5, "X")
# board.update(5, "X")
# board.win?("X")
# board.full?
# puts board.show

# board.move(7, "X")
# board.update(7, "X")
# board.win?("X")
# puts board.show
