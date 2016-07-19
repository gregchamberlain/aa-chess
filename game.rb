require_relative 'board'
require_relative 'display'
require_relative 'humanplayer'
require_relative 'errors'


class Game

  def initialize
    @board = Board.new
    @errors = []
    @display = Display.new(@board, @errors)
    @player1 = HumanPlayer.new("Greg", @display, :white)
    @player2 = HumanPlayer.new("Robert", @display, :black)
    @players = [@player1, @player2]
  end

  def play
    until won?
      pos = start_play
      end_play(pos)
      switch_players
      set_cursor
    end
  end

  def start_play
    start = current_player.get_move
    piece = @board[start]
    raise NullPieceError if piece.is_a?(NullPiece)
    raise WrongPlayerError if piece.color != current_player.color
  rescue NullPieceError => e
    @errors << e
    retry
  rescue WrongPlayerError => e
    @errors << e
    retry
  ensure
    return start
  end

  def end_play(pos)
    finish = current_player.get_move
    piece = @board[pos]
    raise InvalidMoveError unless piece.moves(pos).include?(finish)
    raise InvalidMoveError if @board.any_between?(pos, finish)
    @board.move_piece(pos, finish)
  rescue InvalidMoveError => e
    @errors << e
    retry
  ensure
    finish
  end

  def current_player
    @players.first
  end

  def switch_players
    @players.rotate!
  end

  def set_cursor
    pos = current_player.color == :black ? [6,3] : [1,3]
    @display.set_cursor(pos)
  end

  def play_turn
    p @display.get_input
  end

  def won?
    false
  end





end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.play
end
