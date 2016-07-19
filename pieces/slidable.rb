require_relative 'piece'
require_relative 'nullpiece'
require 'byebug'

class Slidable < Piece

  FLATS = [
    [0,1],
    [0,-1],
    [1,0],
    [-1,0]
  ]

  DIAGONALS = [
    [1,1],
    [1,-1],
    [-1,1],
    [-1,-1],
  ]

  def moves(pos)
    x, y = pos
    self.class.move_dirs.inject([]) do |moves, dir|
      case dir
      when :diagonal
        moves + diagonals(pos)
      when :flats
        moves + flats(pos)
      end
    end
  end

  private

  def crawl(pos, diff)
    new_pos = [pos[0] + diff[0], pos[1] + diff[1]]
    return [] unless new_pos.all?{ |p| p.between?(0, 7) }
    piece = @board[new_pos]
    return [] if piece.color == color
    return [new_pos] if piece.color != self.color && !piece.is_a?(NullPiece)
    [new_pos] + crawl(new_pos, diff)
  end


  def flats(pos)
    FLATS.inject([]) {|moves, diff| moves.concat(crawl(pos, diff))}
  end

  def diagonals(pos)
    DIAGONALS.inject([]) {|moves, diff| moves.concat(crawl(pos, diff))}
  end

end
