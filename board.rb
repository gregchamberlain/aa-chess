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

  def self.emptyBoard(board)
    grid = []
    @nullpiece = NullPiece.instance
    (0..7).each do |idx1|
      row = []
      (0..7).each do |idx2|
        case idx1
        when 0
          row << FACE_PIECE[idx2].new(:white, board)
        when 1
          row << Pawn.new(:white, board)
        when 6
          row << Pawn.new(:black, board)
        when 7
          row << FACE_PIECE.reverse[idx2].new(:black, board)
        else
          row << @nullpiece
        end
      end
      grid << row
    end
    grid
  end

  def initialize(grid = Board.emptyBoard(self))
    @grid = grid
    @nullpiece = self[[2,0]]
  end

  def rows
    @grid
  end

  def take_piece(pos)
    self[pos] = @nullpiece
  end

  def in_check?(color, king_pos = nil)
    king_pos ||= get_king_position(color)
    each_with_position do |piece, pos|
      next if piece.color == color
      if piece.is_a?(Pawn)
        piece_moves = piece.attack_moves(pos)
      else
        piece_moves = piece.moves(pos)
      end
      next unless piece_moves.include?(king_pos)
      return pos
    end
    false
  end

  def checkmate?(color)
    king_pos = get_king_position(color)
    check_pos = in_check?(color, king_pos)

    return false unless check_pos
    return false unless self[king_pos].moves(king_pos).all? {|move| in_check?(color, move)}
    each_with_position do |piece, pos|
      next unless piece.color == color
      next if piece.is_a?(King)
      moves = piece.is_a?(Pawn) ? piece.possible_moves(pos) - [check_pos] : piece.moves(pos)
      return false if moves.any? { |move| will_block?(check_pos, king_pos, move) }
    end
    true
  end

  def in_bounds?(pos)
    x, y = pos
    return false unless x.between?(0, 7) || y.between?(0, 7)
    true
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

  private

  def each_with_position(&prc)
    @grid.each_with_index do |row, row_idx|
      row.each_index do |col_idx|
        prc.call(self[[row_idx,col_idx]], [row_idx, col_idx])
      end
    end
  end

  def will_block?(start, finish, pos)
    rows = [start[0], finish[0]]
    cols = [start[1], finish[1]]
    pos[0].between?(rows.min, rows.max) &&
    pos[1].between?(cols.min, cols.max) &&
    (start[0]-finish[0]).fdiv(start[1]-finish[1]) == (start[0]-pos[0]).fdiv(start[1]-pos[1])
  end

  def each(&prc)
    each_with_position do |piece, position|
      prc.call(piece)
    end
  end

  def get_king_position(color)
    each_with_position do |piece, pos|
      return pos if piece.is_a?(King) && piece.color == color
    end
  end

end
