require_relative 'Piece'

class Pawn < Piece

  attr_reader :symbol

  def initialize(color)
    super
    @symbol = color == :black ? "\u265F" : "\u2659"
    @first_move = true
  end

  def moves(pos)
    x, y = pos
    modifier = @color == :black ? -1 : 1
    possible_moves = @first_move ?
    [[ x+1 * modifier, y],[x+2 * modifier, y]] :
    [[x+1 * modifier, y]]
    @first_move = false
    possible_moves
  end



end
