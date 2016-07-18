require_relative 'Slidable'

class Bishop < Slidable

  attr_reader :symbol

  def initialize(color)
    super
    @symbol = color == :black ? "\u265D" : "\u2657"
  end

  def self.move_dirs
    [:diagonal]
  end

end
