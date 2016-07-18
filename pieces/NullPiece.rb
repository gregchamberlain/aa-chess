require_relative 'Piece'

class NullPiece

  def moves
    []
  end

  def to_s
    "   "
  end

  def valid_move(pos)
    false
  end
end
