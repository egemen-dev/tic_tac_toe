module TikTacToe
  class Board
    attr_reader :cells

    WALLS = '--+---+--'

    NONNUMERICAL = ['', '+', '-', ' ']

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
  end
end

include TikTacToe
board = Board.new
puts board.show
