# require_relative 'lib/game.rb'
require_relative 'lib/ship.rb'
# require_relative 'lib/player.rb'
require_relative 'lib/board.rb'
# require_relative 'lib/fleet.rb'

#fleet = Fleet.new
#fleet.display_fleet

board = Board.new

carrier = Ship.new("Carrier", 5)
battleship = Ship.new("Battleship", 4)
cruiser = Ship.new("Cruiser", 3)
destroyer1 = Ship.new("Destroyer 1", 2)
destroyer2 = Ship.new("Destroyer 2", 2)
submarine1 = Ship.new("Submarine 1", 1)
submarine2 = Ship.new("Submarine 2", 1)
#puts "#{carrier.name} (size #{carrier.size}) created"

#game = BattleShip.new
#game.play


board.place_ship(carrier, 'B', 3, 'H')
board.place_ship(battleship, 'D', 3, 'H')
board.place_ship(cruiser,'F', 5, 'H')
board.place_ship(destroyer1,'A', 1, 'V')
board.place_ship(destroyer2, 'J', 6, 'H')
board.place_ship(submarine1, 'I', 10, 'V')
board.place_ship(submarine2, 'E', 10, 'H')
board.display

#puts "Carrier coordinates: #{carrier.coordinates.inspect}"

puts "\nShip coordinates:"
[carrier, battleship, cruiser, destroyer1, destroyer2, submarine1, submarine2].each do |ship|
  puts "#{ship.name}: #{ship.coordinates.inspect}"
end
