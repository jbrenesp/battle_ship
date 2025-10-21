require_relative 'board.rb'
require_relative 'fleet.rb'

class BattleShip
  attr_accessor :computer_board, :computer_fleet
  def initialize
    puts "Starting Battleship game!"
    @player_board = Board.new
    @computer_board = Board.new

    @player_fleet = Fleet.new
    @computer_fleet = Fleet.new

    #automatically place ships
    @computer_board.place_fleet_randomly(@computer_fleet.ships)

    setup_player_fleet
  end

  def player_turn
    puts "\nYour turn!"
    print "Enter coordinates to fire (e.g. --> B3):"
    #gets waits for the user input, chomp removes the newline character after enter is pressed.
    input = gets.chomp.upcase

    #the input will be splited into row and column
    row = input[0]
    col = input[1..].to_i

    result = @computer_board.fire(row, col)
    puts result
  end

  def setup_player_fleet
    puts "Do you want to place your ships manually or randomly? (M/R)"
    choice = gets.chomp.upcase

    if choice == 'R'
      @player_board.place_fleet_randomly(@player_fleet.ships)
    else
      @player_fleet.ships.each_with_index do |ship, index|
        placed = false
        until placed
          puts "Place Ship #{index + 1}: #{ship.name} (size #{ship.size})"
          print "Enter starting coordinate (e.g., B3)"
          coord = gets.chomp.upcase
          row = coord[0]
          col = coord[1..].to_i

          print "Enter orientation (H: Horizontal, V: Vertical):"
          orientation = gets.chomp.upcase

          if @player_board.valid_placement?(ship, row, col, orientation)
            @player_board.place_ship(ship, row, col, orientation)
            placed = true
          else
            puts "Invalid placement, try again."
          end
        end
      end
    end
  end

  def play
    loop do 
      puts "\nYour Turn!"
      print "Enter coordinates to fire (e.g. --> B3):"
      input = gets.chomp.upcase
      row, col = input[0], input[1..].to_i
      result = @computer_board.fire(row, col)
      puts result

      if @computer_board.all_ships_sunk?
        puts "\nYou Win!!"
        break
      end

      puts "\nComputer's turn..."
      sleep(1)

      begin
        comp_row = Board::ROWS.sample
        comp_col = rand(1..Board::COLUMNS.size)
      end while @player_board.already_fired_at?(comp_row, comp_col)

      result = @player_board.fire(comp_row, comp_col)
      puts "Computer fires at #{comp_row}#{comp_col}: #{result}"

      if @player_board.all_ships_sunk?
        puts"\nComputer wins!"
        break
      end
      
      puts "\nYour Board:"
      @player_board.display

      puts "\nComputer's Board:"
      @computer_board.display_public_view
    end
  end
end
