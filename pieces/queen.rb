require_relative 'slidable'

class Queen < Slidable

  attr_reader :symbol

  def initialize(color, board)
    super
    @symbol = "\u265B"
  end

  def self.move_dirs
    [:flats, :diagonal]
  end

end
