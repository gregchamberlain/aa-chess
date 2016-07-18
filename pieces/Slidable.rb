require_relative 'Piece'

class Slidable < Piece

  def moves(pos)
    x, y = pos
    self.class.move_dirs.inject([]) do |moves, dir|
      case dir
      when :diagonal
        moves + diagonals(pos)
      when :horizontal
        moves + rows(pos)
      when :vertical
        moves + cols(pos)
      end
    end
  end

  def diagonals(pos)
    x, y = pos
    (0...8).to_a.inject([]) do |acc, num|
      acc << [(x+num) % 8, (y+num) % 8]
    end
  end

  def rows(pos)
    x, y = pos
    (0...8).to_a.inject([]) do |acc, num|
      acc << [x, (y+num) % 8]
    end
  end

  def cols(pos)
    x, y = pos
    (0...8).to_a.inject([]) do |acc, num|
      acc << [(x+num) % 8, y]
    end
  end
end
