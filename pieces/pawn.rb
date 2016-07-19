require_relative 'piece'
require_relative 'nullpiece'

class Pawn < Piece

  attr_reader :symbol

  def initialize(color, board)
    super
    @symbol = "\u265F"
    @first_move = true
  end

  def moves(pos)
    modifier = @color == :black ? -1 : 1
    possible_moves(pos, modifier) + attack_moves(pos, modifier)
  end

  def make_move
    @first_move = false
  end

  def possible_moves(pos, modifier)
    x, y = pos
    @first_move ? [[ x+1 * modifier, y],[x+2 * modifier, y]] :
    [[x+1 * modifier, y]]
  end

  def attack_moves(pos, modifier)
    x, y = pos
    [[ x+1 * modifier, y-1],[x+1 * modifier, y+1]].select do |pos|
      piece = @board[pos]
      piece.color != self.color && !piece.is_a?(NullPiece)
    end
  end

end
