require_relative 'slidable'

class Rook < Slidable

  attr_reader :symbol

  def initialize(color)
    super
    @symbol = "\u265C"
  end

  def self.move_dirs
    [:vertical, :horizontal]
  end

end
