class NullPieceError < StandardError
  def message
    "There is no piece here!"
  end
end

class WrongPlayerError < StandardError
  def message
    "This is not your piece!"
  end
end

class InvalidMoveError < StandardError
  def message
    "That piece cannot move there!"
  end
end

class BadSelectError < StandardError
  def message
    "Reset selections"
  end
end
