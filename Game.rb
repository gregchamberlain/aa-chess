require_relative 'Board'
require_relative 'Display'


class Game

  def initialize
    @board = Board.new
    @display = Display.new(@board)
  end

  def play
    until won?

      @display.render
      play_turn
    end
  end

  def play_turn
    p @display.get_input
  end

  def won?
    false
  end





end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.play
end
