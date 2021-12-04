module Display
  def get_names
    names = []
    puts 'Player 1, Please enter your name'
    names << gets.chomp
    puts 'Player 2, Please enter your name'
    names << gets.chomp
    names
  end

  def display_board(grid)
    count = 7
    lineSep = '  +-----+-----+-----+-----+-----+-----+-----+'
    rowInd = '   '
    7.times { |x| rowInd += "  #{x + 1}   " }
    grid.each do |x|
      colSep = "#{count} |"
      x.each { |y| colSep += "  #{y}  |" }
      count -= 1
      puts lineSep
      puts colSep
    end
    puts lineSep
    puts rowInd
  end

  def get_input
    puts "Player #{@id.name}, please enter the Column to mark"
    input = gets.chomp.to_i
    until valid_input?(input)
      puts 'Invalid input, Please enter again'
      input = gets.chomp.to_i
    end
    update_id
    input
  end

  def winner_message
    puts "Congrats, Player #{@id.name} has won the game"
    puts 'Exiting the game now'
  end

  def draw_message
    puts 'The game is unfortunately a draw! :('
  end
end
