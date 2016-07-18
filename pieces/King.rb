require_relative 'Piece'
require_relative 'Steppable'

class King < Steppable

  attr_reader :symbol

  def initialize(color)
    super
    @symbol = color == :black ? "\u265A" : "\u2654"
  end

  def self.moves_diffs
   [
      [1,0],
      [0,1],
      [1,1],
      [-1,0],
      [0,-1],
      [-1,-1],
      [-1,1],
      [1,-1]
    ]
  end

end
