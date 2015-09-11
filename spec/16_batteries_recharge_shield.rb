require_relative 'spec_helper'

describe Battery do
  before :each do
    @battery = Battery.new
  end

  it "should be an item" do
    expect(@battery).to be_an(Item)
  end

  it "has name 'Battery'" do
    expect(@battery.name).to eq("Battery")
  end

  it "has 25 weight" do
    expect(@battery.weight).to eq(25)
  end

  describe "#charge" do
    before :each do
      @robot = Robot.new
    end

    it "resets the robot's shield" do
      expect(@robot).to receive(:recharge_shield)
      @battery.charge(@robot)
    end
  end
end
