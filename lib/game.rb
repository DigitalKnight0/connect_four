require_relative 'player'
require_relative 'board'
require_relative 'display'

class Game
  include Display
  attr_reader :board, :id, :player1, :player2, :turns

  def initialize
    @player1 = nil
    @player2 = nil
    @board = Board.new
    @id = nil
    @turns = 0
  end

  def play
    make_players
    make_board

    loop do
      display_board(@board.grid)
      update_board
      if check_win?
        winner_message
        break
      elsif draw?
        draw_message
        break
      end
      update_turn
    end
  end

  def make_players
    names = get_names
    @player1 = Players.new(names[0], "\u25EF")
    @player2 = Players.new(names[1], "\u25CF")
    @id = @player1
  end

  def make_board
    @board.create_board
  end

  def valid_input?(input)
    input.between?(1, 7) &&
      @board.grid.transpose[input - 1].any?("\u23F7")
  end

  def update_id
    @id = @id == @player1 ? @player2 : @player1
  end

  def update_board
    input = get_input
    @board.mark(input, @id.marker)
  end

  def update_turn
    @turns += 1
  end

  def draw?
    @turns == 49
  end

  def check_win?
    combos = @board.all_combos(@board.grid)
    @board.check_rows(combos)
  end
end

#Game.new.play
