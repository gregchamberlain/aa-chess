require_relative 'piece'
require 'singleton'

class NullPiece
  include Singleton
  def moves(pos)
    []
  end

  def to_s
    "   "
  end

  def valid_move(pos)
    false
  end

  def color
    false
  end
end
