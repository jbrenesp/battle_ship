require_relative 'board.rb'
require_relative 'fleet.rb'

class BattleShip
  def initialize
    puts "Starting Battleship game!"
    @player_board = Board.new
    @computer_board = Board.new

    @player_fleet = Fleet.new
    @computer_fleet = Fleet.new
  end

  def play
    puts "Player's Fleet:"
    @player_fleet.display_fleet

    puts "Player's Board:"
    @player_board.display

    #\n starts on a new line giving space for the new board
    puts "\nComputer's Board:"
    @computer_board.display
  end
end
