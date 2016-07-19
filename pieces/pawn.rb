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
    possible_moves(pos) + attack_moves(pos)
  end

  def make_move
    @first_move = false
  end

  def possible_moves(pos)
    x, y = pos
    modifier = @color == :black ? -1 : 1
    @first_move ? [[ x+1 * modifier, y],[x+2 * modifier, y]] :
    [[x+1 * modifier, y]]
  end

  def attack_moves(pos)
    x, y = pos
    modifier = @color == :black ? -1 : 1
    moves = [[ x+1 * modifier, y-1],[x+1 * modifier, y+1]].select do |pos|
      piece = @board[pos]
      !piece.nil? && piece.color != self.color && !piece.is_a?(NullPiece)
    end
    moves
  end

end
