require_relative 'slidable'

class Bishop < Slidable

  attr_reader :symbol

  def initialize(color)
    super
    @symbol = "\u265D"
  end

  def self.move_dirs
    [:diagonal]
  end

end
