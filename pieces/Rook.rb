require_relative 'Slidable'

class Rook < Slidable

  attr_reader :symbol

  def initialize(color)
    super
    @symbol = color == :black ? "\u265C" : "\u2656"
  end

  def self.move_dirs
    [:vertical, :horizontal]
  end

end
