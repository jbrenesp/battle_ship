# lib/fleet.rb
require_relative 'ship.rb'

class Fleet
  attr_reader :ships
  
  def initialize
    @ships = []
    create_ships
  end

  def create_ships
    @ships << Ship.new("Carrier", 5)
    @ships << Ship.new("Battleship", 4)
    @ships << Ship.new("Cruise", 3)
    @ships << Ship.new("Destroyer 1", 2)
    @ships << Ship.new("Destroyer 2", 2)
    @ships << Ship.new("Submarine 1", 1)
    @ships << Ship.new("Submarine 2", 1)

    def display_fleet
      puts "Fleet:"
      @ships.each { |ship| puts "#{ship.name} (size #{ship.size})"}
    end
  end
  

