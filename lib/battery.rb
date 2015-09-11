class Battery < Item

  def initialize
    super('Battery', 25)
  end

  def charge(robot)
    robot.recharge_shield
  end

end
