class HumanPlayer

  attr_reader :color, :name

  def initialize(name, display, color)
    @name = name
    @display = display
    @color = color
  end

  def get_move
    move = nil
    @display.render
    puts "#{color}'s Turn"
    until move
      move = @display.get_input
      @display.render
      puts "#{color}'s Turn"
    end
    move
  end

end
