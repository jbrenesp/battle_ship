class Setup
  def initialize(player_board, player_fleet)
    @player_board = player_board
    @player_fleet = player_fleet
  end

  def place_player_fleet
    puts "Do you want to place your ships manually or randomly? (M/R)"
    choice = gets.chomp.upcase

    if choice == 'R'
      @player_board.place_fleet_randomly(@player_fleet.ships)
      puts "\nYour ships have been placed randomly."
      @player_board.display
    else
      puts "\nHere is your empty board for ship placement:"
      @player_board.display


      @player_fleet.ships.each_with_index do |ship, index|
        place_ship(ship, index)
      end
    end
  end

  private

  def place_ship(ship, index)
    placed = false
    until placed
      puts "Place Ship #{index + 1}: #{ship.name} (size #{ship.size})"
      print "Enter starting coordinate (e.g., A3)"
      coord = gets.chomp.upcase
      row = coord[0]
      col = coord[1..].to_i
      
      print "Enter orientation (H: Horizontal, V: Vertical):"
      orientation = gets.chomp.upcase
      
      if @player_board.valid_placement?(ship, row, col, orientation)
        @player_board.place_ship(ship, row, col, orientation)
        placed = true
        puts "\n✅#{ship.name} place successfully"
        @player_board.display
      else
        puts "Invalid placement, try again."
      end
    end
  end
end

