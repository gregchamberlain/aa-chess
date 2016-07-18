require './pieces/Rook'
require './pieces/Knight'
require './pieces/Bishop'
require './pieces/King'
require './pieces/Queen'
require './pieces/Pawn'
require './pieces/NullPiece'


class Board

  FACE_PIECE = [
    Rook,
    Knight,
    Bishop,
    Queen,
    King,
    Bishop,
    Knight,
    Rook
  ]

  def self.emptyBoard
    grid = []
    (0..7).each do |idx1|
      row = []
      (0..7).each do |idx2|
        case idx1
        when 0
          row << FACE_PIECE[idx2].new(:white)
        when 1
          row << Pawn.new(:white)
        when 6
          row << Pawn.new(:black)
        when 7
          row << FACE_PIECE.reverse[idx2].new(:black)
        else
          row << NullPiece.new
        end
      end
      grid << row
    end
    grid
  end

  def initialize(grid = Board.emptyBoard)
    @grid = grid
    nil
  end

  def rows
    @grid
  end

  def in_bounds?(pos)
    x, y = pos
    return false unless x.between?(0, 7) || y.between?(0, 7)
    true
  end

  def render
    @grid.each do |row|
      puts row.map(&:to_s).join
      nil
    end
  end
end
