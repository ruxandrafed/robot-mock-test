require_relative 'item'
require_relative 'weapon'
require_relative 'box_of_bolts'
require_relative 'exceptions'

class Robot

  attr_reader :position, :items, :health
  attr_accessor :equipped_weapon

  def initialize
    @position = [0, 0]
    @items = []
    @health = 100
    @equipped_weapon = nil
  end

  def move_left
    @position[0] -= 1
  end

  def move_right
    @position[0] += 1
  end

  def move_down
    @position[1] -= 1
  end

  def move_up
    @position[1] += 1
  end

  def pick_up(item)
    if items_weight + item.weight > 250
      nil
    else
        @equipped_weapon = item if item.is_a? Weapon
        item.feed(self) if (item.is_a? BoxOfBolts) && health <= 80
        items << item
    end
  end

  def items_weight
    items.reduce(0) {|sum, item| sum + item.weight}
  end

  def wound(damage)
    (@health - damage) >= 0 ? @health -= damage : @health = 0
  end

  def heal(health_points)
    (@health + health_points) <= 100 ? @health += health_points : @health = 100
  end

  def heal!(health_points)
    raise RobotIsDead if @health <= 0
    (@health + health_points) <= 100 ? @health += health_points : @health = 100
  end

  def y_distance_from(unit)
    (self.position[1] - unit.position[1]).abs
  end

  def x_distance_from(unit)
    (self.position[0] - unit.position[0]).abs
  end

  def max_distance(unit)
    [x_distance_from(unit), y_distance_from(unit)].max
  end

  def hit_with_grenade(unit)
    @equipped_weapon.hit(unit)
    @equipped_weapon = nil
  end

  def has_grenade?
    @equipped_weapon.is_a? Grenade
  end

  def attack(another_robot)
    if max_distance(another_robot) > 2
      nil
    elsif max_distance(another_robot) > 1
      has_grenade? ? hit_with_grenade(another_robot) : nil
    else
      another_robot.wound(5)
      @equipped_weapon.hit(another_robot) if @equipped_weapon
    end
  end

  def attack!(another_robot)
    raise CannotAttackEnemy unless another_robot.is_a? Robot
    another_robot.wound(5)
    @equipped_weapon.hit(another_robot) if @equipped_weapon
  end

end
