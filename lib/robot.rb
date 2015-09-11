class Robot

  DEFAULT_DAMAGE = 5
  MAX_HEALTH = 100
  MIN_HEALTH = 0
  MAX_WEIGHT = 250
  DEFAULT_SHIELD = 50

  attr_reader :position, :items, :shield
  attr_accessor :equipped_weapon, :health

  def initialize
    @position = [0, 0]
    @items = []
    @health = MAX_HEALTH
    @equipped_weapon = nil
    @shield = 50
    @@all_robots << self
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

  def items_weight
    items.reduce(0) {|sum, item| sum + item.weight}
  end


  def pick_up(item)
    if items_weight + item.weight > MAX_WEIGHT
      nil
    else
        equip_with_weapon(item) if item.is_a? Weapon
        item.feed(self) if (item.is_a? BoxOfBolts) && health <= (MAX_HEALTH - BoxOfBolts::HEAL_POWER)
        @items << item
    end
  end

  def wound(damage)
    if is_shield_empty?
      #(@health - damage) >= 0 ? @health -= damage : @health = 0
      @health = [@health - damage, MIN_HEALTH].max
    elsif can_shield_take_all_damage?(damage)
      @shield -= damage
    else
      excess_damage = damage - @shield
      @shield -= @shield
      @health -= excess_damage
    end
  end

  def heal(health_points)
    #(@health + health_points) <= 100 ? @health += health_points : @health = 100
    @health = [@health + health_points, MAX_HEALTH].min
  end

  def heal!(health_points)
    raise RobotIsDead if @health <= MIN_HEALTH
    #(@health + health_points) <= MAX_HEALTH ? @health += health_points : @health = MAX_HEALTH
    @health = [@health + health_points, MAX_HEALTH].min
  end

  def attack(victim = nil)
    if has_special_weapon?
      hit_with_special_weapon
    else
      if max_distance(victim) > 2
        nil
      elsif max_distance(victim) > 1
        has_grenade? ? hit_with_grenade(victim) : nil
      else
        has_grenade? ? hit_with_grenade(victim) : nil
        @equipped_weapon ? @equipped_weapon.hit(victim) : victim.wound(DEFAULT_DAMAGE)
      end
    end
  end

  def attack!(victim)
    raise CannotAttackEnemy unless victim.is_a? Robot
    victim.wound(5)
    @equipped_weapon.hit(victim) if @equipped_weapon
  end

  def recharge_shield
    @shield = DEFAULT_SHIELD
  end

  def scan_enemies
    x = position[0]
    y = position[1]
    all_enemies =[]
    surroundings = [[-1, -1], [-1, 0], [-1, 1], [0, 1], [0, -1], [1, 1], [1, 0], [1, -1]]
    surroundings = surroundings.map do |e|
      Robot.in_position(x+e[0], y+e[1]).each {|elem| all_enemies << elem}
    end
    all_enemies
  end

  def hit_with_special_weapon
    scan_enemies.each { |enemy| @equipped_weapon.hit(enemy) }
    @equipped_weapon = nil
  end

  private
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

    def has_special_weapon?
      @equipped_weapon.is_a? SpecialWeapon
    end

    def equip_with_weapon(item)
      @equipped_weapon = item
    end

    def is_shield_empty?
      @shield == 0
    end

    def can_shield_take_all_damage?(damage)
      damage <= @shield
    end


  class << self

    attr_reader :all_robots
    @@all_robots = []

    def in_position(x, y)
      @@all_robots.select {|robot| robot.position == [x, y]}
    end

  end

end
