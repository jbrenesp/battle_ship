require_relative 'board.rb'
require_relative 'fleet.rb'
require_relative 'setup.rb'
require_relative 'ai_player.rb'

class BattleShip
  attr_accessor :computer_board, :computer_fleet

  def initialize
    puts "Starting Battleship game!"

    @player_board = Board.new
    @computer_board = Board.new
    @player_fleet = Fleet.new
    @computer_fleet = Fleet.new
    @computer_ai = AIPlayer.new

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
      input = gets.chomp.upcase

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
    sleep(2)
    
    # Let the AI choose a target
    result, (row, col) = @computer_ai.take_turn(@player_board)
    
    # Print hit/miss first
    if result == "Hit"
      puts "🔥 The computer hit one of your ships at #{row}#{col}!"
    elsif result == "Miss"
      puts "💦 The computer missed at #{row}#{col}."
    end
    
    # Then show the updated board
    @player_board.display
    
    # Check for end game
    if @player_board.all_ships_sunk?
      puts "\n💀 All your ships are sunk! The computer wins!"
      exit
    end
  end



  def show_boards
    puts "\nYour Board:"
    @player_board.display
    puts "\nComputer's Board:"
    @computer_board.display_public_view
  end
end   