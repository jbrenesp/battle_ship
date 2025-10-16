#lib/board.rb
class Board
  #constants (never change) .to_a so i can loop or acces elements
  ROWS = ('A'..'J').to_a
  COLUMNS = (1..10).to_a

  def initialize
    #creates a 10 x10 grid (~ represents water)
    @grid = Array.new(ROWS.size) {Array.new(COLUMNS.size, '~')}
  end

  def display
    #prints column headers
    puts "  " + COLUMNS.join('   ')
    #prints each row with the row letter
    @grid.each_with_index do |row, i|
      puts "#{ROWS[i]} #{row.join('   ')}"
    end
  end

  def valid_placement?(ship, start_row, start_col, orientation)
    row_index = ROWS.index(start_row)
    col_index = start_col - 1

    ship.size.times do |i|
      if orientation == 'H'
        return false if col_index + i >= COLUMNS.size
        return false if @grid[row_index][col_index + i] != '~'
      elsif orientation == 'V'
        return false if row_index + i >= ROWS.size
        return false if @grid[row_index + i][col_index] != '~'
      end
    end
    true
  end


# parameters or arguments are inside the parenthesis
  def place_ship(ship, start_row, start_col, orientation)
    return puts "Invalid placement for #{ship.name}!" unless valid_placement?(ship, start_row, start_col, orientation)
    # with index(start_row) it finds the position of the letter inside the array
    row_index = ROWS.index(start_row)
    # we use start_col - 1 because the ruby index starts at 0
    col_index = start_col - 1
    # .size.times do i takes the size of the ship and moves through the row or column
    ship.size.times do |i|
      if orientation == 'H'
        if @grid[row_index][col_index + i] == 'S'
          raise "Cannot place #{ship.name}: space already taken!"
        end
        @grid[row_index][col_index + i] = 'S'
        # ship coordinates is an array and << appends a new element to the array
        ship.coordinates << [start_row, start_col + i]
      elsif orientation == 'V'
        if @grid[row_index + i][col_index] == 'S'
          raise "Cannot place #{ship.name}: space already taken!"
        end
        @grid[row_index + i][col_index] = 'S'
        ship.coordinates << [ROWS[row_index + i], start_col]
      end
    end
  end
end

