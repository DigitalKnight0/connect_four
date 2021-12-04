module Helper
  def check_rows(grid)
    combos = []
    grid.each do |x|
      x.size.times { |y| combos << x[y..y + 3] }
    end
    combos.keep_if { |x| x.size == 4 }
    combos.any? { |x| x.uniq.size == 1 }
  end

  def diagonals_to_rows(grid)
    sets = []
    grid.each_index do |x|
      row = []
      grid.length.times do |y|
        row << grid[y][y + x]
      end
      sets << row
    end
    sets.each { |x| x.compact! }
    sets
  end

  def all_combos(grid)
    grid_rev = []
    grid.each { |x| grid_rev << x.reverse }
    arr = grid
    arr += grid.transpose
    arr += diagonals_to_rows(grid)
    arr += diagonals_to_rows(grid.transpose)
    arr += diagonals_to_rows(grid_rev)
    arr += diagonals_to_rows(grid_rev.transpose)
    arr.uniq.keep_if { |x| x.size == 4 }
  end
end

include Helper
comb = all_combos([[1, 2, 3, 4], [5, 6, 4, 8], [9, 4, 11, 12], [4, 14, 15, 16]])
p check_rows(comb)
