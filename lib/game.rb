require_relative 'board.rb'
require_relative 'fleet.rb'
require_relative 'setup.rb'

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

    Setup.new(@player_board, @player_fleet).place_player_fleet
  end

  def play
    loop do 
      player_turn
      break if @computer_board.all_ships_sunk?

      computer_turn
      break if @player_board.all_ships_sunk?

      show_boards
    end
  end

  private

  def player_turn
    puts "\nYour turn!"
    loop do
      print "Enter coordinates to fire (e.g., B3):"
      input = gets.chomp.upcasa

      row = input[0]
      col = input[1..].to_i

      unless Board::ROWS.include?(row) && Board::COLUMNS.include?(col)
        puts "❌ Invalid input. Use a valid coordinate (e.g., A1-#{Board::ROWS.last}#{Board::COLUMNS.last})."
        next
      end

      if @computer_board.already_fired_at?(row,col)
        puts "⚠️ You already fired at #{row}#{col}. Try again!"
        next
      end
      
      result = @computer_board.fire(row,col)
      puts result
      break
    end
  end

  def computer_turn
    puts "\nComputer's turn..."
    sleep(3)

    begin
      comp_row = Board::ROWS.sample
      comp_col = rand(1..Board::COLUMNS.size)
    end while @player_board.already_fired_at?(comp_row, comp_col)

    result = @player_board.fire(comp_row, comp_col)
    puts "Computer fires at #{comp_row}#{comp_col}: #{result}"
  end

  def show_boards
    puts "\nYour Board:"
    @player_board.display
    puts "\nComputer's Board:"
    @computer_board.display_public_view
  end
end   