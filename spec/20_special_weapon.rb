require_relative 'spec_helper'

describe Robot do

  describe '#attack' do

    before :each do
      @robot = Robot.new # final position (0, 0)
      @special_weapon = SpecialWeapon.new
    end


    context "equipped with special weapon" do

      before :each do
        @robot.equipped_weapon = @special_weapon
        @robot2 = Robot.new
        @robot2.move_up
        @robot2.move_up # final position (0, 2)
        @robot3 = Robot.new
        @robot3.move_right # final position (1, 0)
      end

      it "is able to successfully wound enemies in tiles immediately next to him" do
        expect(@robot3.health).to equal(70)
        @robot.attack
      end

      it "is NOT able to successfully wound the enemy who is not in a tile next to him" do
        expect(@robot3.health).to equal(100)
        @robot.attack
      end

      it "should dispense the weapon (can only use once)" do
        expect(@robot.equipped_weapon).to be_nil
        @robot.attack
      end

    end

  end

end
