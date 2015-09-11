require_relative 'spec_helper'

describe Robot do

  before :each do
    @@all_robots = []
  end

  describe ".in_position(x,y)" do

    it 'returns array of robots at position 0, 0' do
      @robot1 = Robot.new
      @robot2 = Robot.new
      expect(Robot.in_position(0, 0)).to eq([@robot1, @robot2])
    end

    it 'returns array of robots at position 0, 1' do
      @robot1 = Robot.new
      @robot1.move_up
      @robot2 = Robot.new
      expect(Robot.in_position(0, 1)).to eq([@robot1])
    end

  end

end
