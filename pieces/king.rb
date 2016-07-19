require_relative 'piece'
require_relative 'steppable'

class King < Steppable

  attr_reader :symbol

  def initialize(color, board)
    super
    @symbol = "\u265A"
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
