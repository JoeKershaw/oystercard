class Station
  attr_reader :name, :zone
  def initialize(name, zone)
    @name = name
    @zone = zone
  end
end

# kings_Cross = Station("KC", 2)
