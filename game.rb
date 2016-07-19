require_relative 'board'
require_relative 'display'
require_relative 'humanplayer'
require_relative 'errors'


class Game

  def initialize
    @board = Board.new
    @errors = []
    @current_piece = [nil]
    @display = Display.new(@board, @errors, @current_piece)
    @player1 = HumanPlayer.new("Greg", @display, :white)
    @player2 = HumanPlayer.new("Robert", @display, :black)
    @players = [@player1, @player2]
  end

  def play
    until won?
      begin
        pos = start_play
        end_play(pos)
      rescue BadSelectError => e
        retry
      ensure
        switch_players
        set_cursor
      end
    end
    @display.render
    puts "#{current_player.name}, you've lost!"
  end

  def start_play
    @current_piece[0] = nil
    in_check = @board.in_check?(current_player.color)
    @errors << InCheckError.new if in_check
    start = current_player.get_move
    raise BadSelectError if start == :reset
    piece = @board[start]
    raise NullPieceError if piece.is_a?(NullPiece)
    raise WrongPlayerError if piece.color != current_player.color
    @current_piece[0] = piece
  rescue BadSelectError
    retry
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
    raise BadSelectError if finish == :reset
    piece = @board[pos]
    raise InvalidMoveError unless piece.moves(pos).include?(finish)
    # if @board.in_check?(current_player.color)
    #   raise InvalidMoveError if  @board.simulate_move(pos, finish).in_check?(current_player.color)
    # end
    piece.make_move
    @board.take_piece(finish)
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
    @board.checkmate?(current_player.color)
  end





end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.play
end
