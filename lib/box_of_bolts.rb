class BoxOfBolts < Item

  HEAL_POWER = 20

  def initialize
    super('Box of bolts', 25)
    # @name = 'Box of bolts'
    # @weight = 25
  end

  def feed(robot)
    robot.heal(HEAL_POWER)
  end

end
