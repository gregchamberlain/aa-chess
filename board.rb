require './pieces/rook'
require './pieces/knight'
require './pieces/bishop'
require './pieces/king'
require './pieces/queen'
require './pieces/pawn'
require './pieces/nullpiece'


class Board

  FACE_PIECE = [
    Rook,
    Knight,
    Bishop,
    Queen,
    King,
    Bishop,
    Knight,
    Rook
  ]

  def self.emptyBoard
    grid = []
    @nullpiece = NullPiece.instance
    (0..7).each do |idx1|
      row = []
      (0..7).each do |idx2|
        case idx1
        when 0
          row << FACE_PIECE[idx2].new(:white)
        when 1
          row << Pawn.new(:white)
        when 6
          row << Pawn.new(:black)
        when 7
          row << FACE_PIECE.reverse[idx2].new(:black)
        else
          row << @nullpiece
        end
      end
      grid << row
    end
    grid
  end

  def initialize(grid = Board.emptyBoard)
    @grid = grid
  end

  def rows
    @grid
  end

  def take_piece(pos)
    return if self[pos].is_a?(NullPiece)
    self[pos] = @nullpiece
  end

  def any_between?(start, finish)
    return false if self[start].is_a?(Knight)
    diff_x = start[0] - finish[0]
    diff_y = start[1] - finish[1]
    if diff_x == diff_y
      between_diag?(start, finish)
    elsif diff_x == 0
      between_horiz?(start, finish)
    else
      between_vert?(start, finish)
    end
  end

  def between_diag?(start, finish)
    row = (start[1]..finish[1] - 1).to_a
    col = (start[0]..finish[0] - 1).to_a
    between?(row, col)
  end

  def between_horiz?(start, finish)
    row = (start[1]..finish[1] - 1).to_a
    col = Array.new(row.length, start[0])
    between?(row, col)
  end

  def between_vert?(start, finish)
    col = (start[0]..finish[0] - 1).to_a
    row = Array.new(col.length, start[1])
    between?(row, col)
  end

  def between?(row, col)
    row.each_with_index do |x, idx|
      piece = self[[x, col[idx]]]
      return true unless piece.is_a?(NullPiece)
    end
    false
  end

  def in_check?(color, king_pos = nil)
    king_pos ||= get_king_position(color)
    self.each_with_position do |piece, pos|
      next if piece.color == color
      piece_moves = piece.moves
      next unless piece_moves.include?(king_pos)
      return true unless any_between?(pos, king_pos)
    end
    false
  end

  def checkmate?(color)
    king_pos = get_king_position(color)
    return false unless in_check?(color)
    self[king_pos].moves.any? {|move| in_check?(color, move)}
  end

  def get_king_position(color)
    self.each_with_position do |piece, pos|
      return pos if piece.is_a?(King) && piece.color == color
    end
  end

  def each(&prc)
    self.each_with_position do |piece, position|
      prc.call(piece)
    end
  end

  def each_with_position(&prc)
    @grid.each do |row|
      row.each do |col|
        prc.call(self[[row,col]], [row, col])
      end
    end
  end

  def in_bounds?(pos)
    x, y = pos
    return false unless x.between?(0, 7) || y.between?(0, 7)
    true
  end

  def render
    @grid.each do |row|
      puts row.map(&:to_s).join
    end
  end

  def [](pos)
    x, y = pos
    return nil if @grid[x].nil?
    @grid[x][y]
  end

  def []=(pos, piece)
    x, y = pos
    @grid[x][y] = piece
  end

  def move_piece(start, finish)
    self[start], self[finish] = self[finish], self[start]
  end

end
