require_relative 'piece'

class Steppable < Piece

  def moves(pos)
    self.class.moves_diffs.map do |move|
      [pos.first + move.first, pos.last + move.last]
    end.select {|pos| pos.first.between?(0,7) && pos.last.between?(0,7)}
  end



end
