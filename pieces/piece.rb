require 'colorize'

class Piece

  attr_reader :color

  def initialize(color, board)
    @color = color
    @board = board
  end

  def to_s
    " #{symbol} ".colorize(@color == :white ? :light_white : :black)
  end

  def make_move

  end


end
