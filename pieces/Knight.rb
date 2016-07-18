require_relative 'Piece'
require_relative 'Steppable'

class Knight < Steppable

  attr_reader :symbol

  def initialize(color)
    super
    @symbol = color == :black ? "\u2658" : "\u265E"
  end

  def self.move_diffs
    [
      [1,2],
      [2,1],
      [-1,2],
      [-2,1],
      [1,-2],
      [2,-1],
      [-2,-1],
      [-1,-2]
    ]
  end

end
