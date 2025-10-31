class Ship
  attr_reader :name, :size, :coordinates

  def initialize(name, size)
    @name = name
    @size = size
    @coordinates = []
  end
end
