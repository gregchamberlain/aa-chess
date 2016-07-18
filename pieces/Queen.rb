require_relative 'Slidable'

class Queen < Slidable

  attr_reader :symbol

  def initialize(color)
    super
    @symbol = color == :black ? "\u265B" : "\u2655"
  end

  def self.move_dirs
    [:vertical, :horizontal, :diagonal]
  end

end
