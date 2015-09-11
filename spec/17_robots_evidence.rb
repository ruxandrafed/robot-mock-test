require_relative 'spec_helper'

describe Robot do

  before :each do
    @@all_robots = []
  end

  describe "Robot.all_robots" do

    it 'is an array' do
      expect(Robot.class_variable_get(:@@all_robots)).to be_an(Array)
    end

    it 'initially is empty' do
      expect(Robot.class_variable_get(:@@all_robots).size).to equal(0)
    end

    it 'updates when an instance is created' do
      @robot1 = Robot.new
      expect(Robot.class_variable_get(:@@all_robots)).to eq([@robot1])
      @robot2 = Robot.new
      expect(Robot.class_variable_get(:@@all_robots)).to eq([@robot1, @robot2])
    end

  end

end
