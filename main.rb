require_relative 'lib/game.rb'
require_relative 'lib/ship.rb'
# require_relative 'lib/player.rb'
require_relative 'lib/board.rb'
require_relative 'lib/fleet.rb'




computer_board = Board.new
computer_fleet = Fleet.new

computer_board.place_fleet_randomly(computer_fleet.ships)

puts "Computer Board for testing:"
computer_board.display

puts "\nComputer Ship Coordinates:"
computer_fleet.ships.each do |ship|
  puts "#{ship.name}: #{ship.coordinates.inspect}"
end

game = BattleShip.new
game.computer_board = computer_board
game.computer_fleet = computer_fleet

game.player_turn
puts "\nComputer Board after player turn:"
computer_board.display

