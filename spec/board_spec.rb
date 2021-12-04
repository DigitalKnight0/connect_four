require_relative '../lib/board'

RSpec.describe Board do
  describe '#create_board' do
    subject(:my_board) { described_class.new }
    it 'Makes a 7x7 grid' do
      expect { my_board.create_board }.to change { my_board.grid.flatten.size }.by(49)
    end
  end

  describe '#mark' do
    subject(:my_board) { described_class.new }
    context 'It marks the board correctly' do
      before do
        my_board.create_board
      end
      it 'Marks at the correct column with correct symbol' do
        expect { my_board.mark(1, 'X') }.to change { my_board.grid[6][0] }.to('X')
      end
    end
    context 'It checks for previous entries' do
      before do
        my_board.create_board
        my_board.grid[6][0] = 'X'
        my_board.grid[5][0] = 'X'
        my_board.grid[4][0] = 'X'
      end
      it 'When there are 3 previous entries' do
        expect { my_board.mark(1, 'X') }.to change { my_board.grid[3][0] }.to('X')
      end
    end
  end

  describe '#check_rows' do
    subject(:rows) { described_class.new }
    context 'It checks for all combinations for 4' do
      it 'when there is a match' do
        grid = [[2, 3, 1, 4, 3, 3, 3, 3, 7, 4, 5]]
        expect(rows.check_rows(grid)).to be_truthy
      end

      it 'when there is no match' do
        grid = [[1, 2, 3, 4, 5, 6, 7, 8, 9]]
        expect(rows.check_rows(grid)).to be_falsy
      end
    end
  end

  describe '#diagonals_to_rows' do
    subject(:converter) { described_class.new }
    context 'it converts upper diagonals to rows' do
      it 'For a 2x2 grid' do
        grid = [[1, 2], [3, 4]]
        expected = [[1, 4], [2]]
        outcome = converter.diagonals_to_rows(grid)
        expect(expected).to eql(outcome)
      end

      it 'for a 3x3 grid' do
        grid = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
        expected = [[1, 5, 9], [2, 6], [3]]
        outcome = converter.diagonals_to_rows(grid)
        expect(outcome).to eql(expected)
      end
    end
  end

  describe '#all_combos' do
    subject(:my_board) { described_class.new }
    context 'it returns all possible combinations of size 4' do
      it 'for 2x2 grid' do
        grid = [[1, 2], [3, 4]]
        expected = []
        outcome = my_board.all_combos(grid)
        expect(outcome).to eql(expected)
      end

      it 'for 4x4 grid' do
        grid = [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16]]
        expected = [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16], [1, 5, 9, 13], [2, 6, 10, 14],
                    [3, 7, 11, 15], [4, 8, 12, 16], [1, 6, 11, 16], [4, 7, 10, 13]]
        outcome = my_board.all_combos(grid)
        expect(outcome.flatten.sort).to eql(expected.flatten.sort)
      end
    end
  end
end
