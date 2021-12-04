class Board
  attr_accessor :grid

  def initialize
    @grid = []
  end

  def create_board
    7.times do |i|
      @grid.push([])
      7.times do |_j|
        @grid[i].push("\u23F7")
      end
    end
  end

  def mark(input, symbol)
    ind1 = input - 1
    @grid = @grid.transpose
    ind2 = @grid[ind1].each_index.select { |x| @grid[ind1][x] == "\u23F7" }.last
    @grid[ind1][ind2] = symbol
    @grid = @grid.transpose
  end

  def check_rows(grids)
    combos = []
    grids.each do |x|
      x.size.times { |y| combos << x[y..y + 3] }
    end
    combos.keep_if { |x| x.size == 4 }
    combos.any? { |x| x.uniq.size == 1 && x.none?("\u23F7") }
  end

  def diagonals_to_rows(grids)
    sets = []
    grids.each_index do |x|
      row = []
      grids.length.times do |y|
        row << grids[y][y + x]
      end
      sets << row
    end
    sets.each { |x| x.compact! }
    sets
  end

  def all_combos(grids)
    grid_rev = []
    grids.each { |x| grid_rev << x.reverse }
    arr = grids
    arr += grids.transpose
    arr += diagonals_to_rows(grids)
    arr += diagonals_to_rows(grids.transpose)
    arr += diagonals_to_rows(grid_rev)
    arr += diagonals_to_rows(grid_rev.transpose)
    arr.uniq.keep_if { |x| x.size >= 4 }
  end
end
