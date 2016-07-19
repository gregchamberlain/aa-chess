require "colorize"
require_relative "cursorable"

class Display
  include Cursorable

  def initialize(board, errors, current_piece, valid_moves)
    @errors = errors
    @valid_moves = valid_moves
    @current_piece = current_piece
    @board = board
    @cursor_pos = [1, 3]
  end

  def set_cursor(pos)
    x, y = pos
    @cursor_pos[0], @cursor_pos[1] = x, y
  end

  def render
    system("clear")
    puts "Fill the grid!"
    puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
    build_grid.each { |row| puts row.join }
    puts "Current Piece: #{@current_piece[0].to_s.colorize({background: :light_black})}"
    @errors.each { |e| puts e.message.colorize(:red) }
    @errors.clear
  end

  private

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

end
