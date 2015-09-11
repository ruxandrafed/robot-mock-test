require_relative 'spec_helper'

describe Robot do

  before :each do
    @@all_robots = []
  end

  describe "#scan_enemies" do

    it 'returns array of robots found in tiles immediately next to current position' do
      @robot1 = Robot.new
      @robot2 = Robot.new
      @robot3 = Robot.new
      @robot4 = Robot.new
      @robot2.move_up # final position (0, 1)
      @robot3.move_down # final position (0, -1)
      @robot4.move_left
      @robot4.move_left # final position (-2, 0)
      expect(@robot1.scan_enemies).to eq([@robot2, @robot3])
    end

  end

end
