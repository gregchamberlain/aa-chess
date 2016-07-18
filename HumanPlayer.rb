class HumanPlayer
  def initialize(name, display, color)
    @name = name
    @display = display
    @color = color
  end

  def get_move
    @display.get_input
  end
end
