require_relative 'piece'
require_relative 'nullpiece'
require 'byebug'

class Slidable < Piece

  def moves(pos)
    x, y = pos
    self.class.move_dirs.inject([]) do |moves, dir|
      case dir
      when :diagonal
        moves + diagonals(pos)
      when :horizontal
        moves + rows(pos)
      when :vertical
        moves + cols(pos)
      end
    end
  end

  def diagonals(pos)
    x, y = pos
    pos.min.downto(0)
    (0...8).to_a.inject([]) do |acc, num|
      acc << [(x+num) % 8, (y+num) % 8]
    end
  end

  def diagonals(pos)
    moves = []
    moves.concat(crawl(pos, [1,1]))
    moves.concat(crawl(pos, [1,-1]))
    moves.concat(crawl(pos, [-1,1]))
    moves.concat(crawl(pos, [-1,-1]))
    moves
  end

  def crawl(pos, diff)
    new_pos = [pos[0] + diff[0], pos[1] + diff[1]]
    return [] unless new_pos.all?{ |p| p.between?(0, 7) }
    piece = @board[new_pos]
    return [] if piece.color == color
    return [new_pos] if piece.color != self.color && !piece.is_a?(NullPiece)
    [new_pos] + crawl(new_pos, diff)
  end

  def rows(pos)
    moves = []
    moves.concat(crawl(pos, [0,1]))
    moves.concat(crawl(pos, [0,-1]))
    moves.concat(crawl(pos, [0,1]))
    moves.concat(crawl(pos, [0,-1]))
    moves
  end

  def cols(pos)
    moves = []
    moves.concat(crawl(pos, [1,0]))
    moves.concat(crawl(pos, [1,0]))
    moves.concat(crawl(pos, [-1,0]))
    moves.concat(crawl(pos, [-1,0]))
    moves
  end
end
