require_relative 'board'

class BattleShip
  def initialize
    puts "Starting Battleship game!"
    @player_board = Board.new
    @computer_board = Board.new
  end

  def play
    puts "Player's Board:"
    @player_board.display
    

    puts "\nComputer's Board:"
    @computer_board.display
  end
end
