# require_relative 'lib/game.rb'
require_relative 'lib/ship.rb'
# require_relative 'lib/player.rb'
# require_relative 'lib/board.rb'

carrier = Ship.new("Carrier", 5)
puts "#{carrier.name} (size #{carrier.size}) created"

#game = BattleShip.new
#game.play

#board = Board.new
#board.display