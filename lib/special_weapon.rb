class SpecialWeapon < Grenade

  SPECIAL_WEAPON_DAMAGE = 30

  attr_reader :range

  def initialize
    @name = 'Special Weapon'
    @weight = 40
    @range = 1
  end

  def hit(victim)
    victim.health -= SPECIAL_WEAPON_DAMAGE
  end

end

