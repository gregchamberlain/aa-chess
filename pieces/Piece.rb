class Piece

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def to_s
    " #{symbol} "
  end

  def valid_move

  end

  def move_into_check
    # check if move results in king being place in check
  end


end