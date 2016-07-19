require_relative 'piece'
require_relative 'steppable'

class Knight < Steppable

  attr_reader :symbol

  def initialize(color, board)
    super
    @symbol = "\u265E"
  end

  def self.moves_diffs
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
