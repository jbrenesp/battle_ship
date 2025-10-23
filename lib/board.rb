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
      display_row = row.map do |cell|
        case cell
        when 'X' then "\e[32mX\e[0m"
        when 'O' then "\e[31mO\e[0m"
        else cell
        end
      end
      puts "#{ROWS[i]} #{display_row.join('   ')}"
    end
  end

  def display_public_view
  # print column headers
  puts "  " + COLUMNS.join('   ')
  # print each row with hidden ships
  @grid.each_with_index do |row, i|
    display_row = row.map do |cell|
      case cell
      when 'S' then '~'
      when 'X' then "\e[32mX\e[0m"
      when 'O' then "\e[31mO\e[0m"
      else cell
      end
    end
    puts "#{ROWS[i]} #{display_row.join('   ')}"
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

  def place_fleet_randomly(fleet)
    fleet.each do |ship|
      placed = false
      until placed
        start_row = ROWS.sample
        start_col = (1..@grid.first.size).to_a.sample
        orientation = ['H', 'V'].sample
        if valid_placement?(ship, start_row, start_col, orientation)
          place_ship(ship, start_row, start_col, orientation)
          placed = true
        end
      end
    end
  end

  def fire(row, col)
    row_index = ROWS.index(row)
    col_index = col -1

    if @grid[row_index][col_index] == 'S'
      @grid[row_index][col_index] = 'X'
      return "Hit"
    elsif @grid[row_index][col_index] == '~'
      @grid[row_index][col_index] = 'O'
      return 'Miss'
    else
      return "Already fired here!!"
    end
  end

  def already_fired_at?(row, col)
    row = ROWS.index(row.upcase)
    col = col.to_i - 1
    cell = @grid[row][col]
    cell == 'X' || cell == "O"
  end

  def all_ships_sunk?
    # If there are no 'S' (ships) left, all are sunk, 2D grid into a 1D array
    !@grid.flatten.include?('S')
  end
end