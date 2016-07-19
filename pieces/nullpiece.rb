require_relative 'piece'
require 'singleton'

class NullPiece
  include Singleton
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
