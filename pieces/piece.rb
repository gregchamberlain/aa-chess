require 'colorize'

class Piece

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def to_s
    " #{symbol} ".colorize(@color == :white ? :light_white : :black)
  end

  def valid_move

  end


end
