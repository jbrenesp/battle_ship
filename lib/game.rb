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
end
