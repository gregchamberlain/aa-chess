require "colorize"
require_relative "cursorable"

class Display
  include Cursorable

  def initialize(board, errors)
    @errors = errors
    @board = board
    @cursor_pos = [1, 3]
  end

  def set_cursor(pos)
    x, y = pos
    @cursor_pos[0], @cursor_pos[1] = x, y
  end

  def build_grid
    @board.rows.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif (i + j).odd?
      bg = :light_black
    else
      bg = :white
    end
    { background: bg }
  end

  def render
    system("clear")
    puts "Fill the grid!"
    puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
    @errors.each { |e| puts e.message }
    build_grid.each { |row| puts row.join }
    @errors.clear
  end
end
