require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'
require_relative '../lib/display'

RSpec.describe Game do
  describe '#make_players' do
    subject(:new_players) { described_class.new }
    context 'It creates new Players' do
      before do
        allow(new_players).to receive(:get_names).and_return(%w[jack alice])
        allow(Players).to receive(:new)
      end
      it 'Sends a message to create new players' do
        expect(Players).to receive(:new).with('jack', any_args).once
        expect(Players).to receive(:new).with('alice', any_args).once
        new_players.make_players
      end
    end

    context 'It sets the id' do
      before do
        allow(new_players).to receive(:get_names).and_return([1, 2])
        allow(Players).to receive(:new).and_return('Player1')
      end

      it 'Sets id to player one' do
        expect { new_players.make_players }.to change { new_players.id }.to('Player1')
      end
    end
  end

  describe '#make_board' do
    subject(:my_board) { described_class.new }
    let(:board) { instance_double(Board) }
    context 'Makes a new board' do
      it 'sends a message to make a new board' do
        my_board.instance_variable_set('@board', board)
        expect(board).to receive(:create_board).once
        my_board.make_board
      end
    end
  end

  describe '#valid_input?' do
    subject(:check_input) { described_class.new }
    before do
      check_input.make_board
    end
    context 'it checks the range' do
      it 'When the input is within valid range' do
        input = 5
        expect(check_input.valid_input?(input)).to be_truthy
      end

      it 'When the input is outside the range' do
        input = 10
        expect(check_input.valid_input?(input)).to be_falsey
      end
    end

    context 'It checks the board locations' do
      before do
        check_input.board.grid.each do |x|
          x[0] = 'x'
        end
      end
      it 'When the column is occupied' do
        input = 1
        expect(check_input.valid_input?(1)).to be_falsy
      end
      it 'when the column is not occupied' do
        input = 2
        expect(check_input.valid_input?(input)).to be_truthy
      end
    end
  end

  describe '#update_id' do
    subject(:id_check) { described_class.new }
    before do
      id_check.instance_variable_set('@player1', 'P1')
      id_check.instance_variable_set('@player1', 'P2')
    end
    context 'It updates the ids' do
      it 'When the id is player 1' do
        id_check.instance_variable_set('@id', id_check.player1)
        expect { id_check.update_id }.to change { id_check.id }.to(id_check.player2)
      end
      it 'when the id is player 2' do
        id_check.instance_variable_set('@id', id_check.player2)
        expect { id_check.update_id }.to change { id_check.id }.to(id_check.player1)
      end
    end
  end

  describe '#update_board' do
    subject(:my_game) { described_class.new }
    let(:my_board) { instance_double(Board) }
    context 'It sends a message to update the board' do
      before do
        allow_message_expectations_on_nil
        my_game.instance_variable_set('@board', my_board)
        allow(my_board).to receive(:mark)
        allow(my_game).to receive(:get_input).and_return(1)
        allow(my_game.id).to receive(:marker).and_return('any')
      end
      it 'Calls for the marker' do
        expect(my_board).to receive(:mark).with(1, 'any').once
        my_game.update_board
      end
    end
  end

  describe '#update_turn' do
    subject(:check_turns) { described_class.new }
    context 'it updates the number of turns' do
      it 'updates the turn by 1' do
        expect { check_turns.update_turn }.to change { check_turns.turns }.by(1)
      end
    end
  end

  describe '#draw?' do
    subject(:check_draw) { described_class.new }
    it 'returns true if the game is draw' do
      check_draw.instance_variable_set('@turns', 49)
      expect(check_draw.draw?).to be_truthy
    end
  end

  describe 'check_win?' do
    subject(:winner) { described_class.new }
    let(:my_board) { instance_double(Board) }
    context 'It sends the appropriate messages' do
      before do
        winner.instance_variable_set('@board', my_board)
        allow(my_board).to receive(:all_combos)
        allow(my_board).to receive(:check_rows)
        allow(my_board).to receive(:grid)
      end

      it 'sends the messages' do
        expect(my_board).to receive(:all_combos).once
        expect(my_board).to receive(:check_rows).once
        winner.check_win?
      end
    end
  end
end
