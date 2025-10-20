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
    @player_board.place_fleet_randomly(@player_fleet.ships)
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

  def play
    loop do 
      puts "\nYour Turn!"
      print "Enter coordinates to fire (e.g. --> B3):"
      input = gets.chomp.upcase
      row, col = input [0], input[1..].to_i
      result = @computer_board.fire(row, col)
      puts result

      if @computer_board.all_ships_sunk?
        puts "nYou Win!!"
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

      puts "\n Computer's Board:"
      @computer_board.display_public_view
    end
  end
end
