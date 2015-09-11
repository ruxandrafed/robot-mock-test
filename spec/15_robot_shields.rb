require_relative 'spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
  end

  context "takes damage that depletes shield" do
    describe "#wound" do
      it "decreases health" do
        @robot.wound(70)
        expect(@robot.health).to eq(80)
      end

      it "doesn't decrease health below 0" do
        @robot.wound(150)
        expect(@robot.health).to eq(0)
      end
    end
  end

  context "takes damage that doesn't deplete shield" do
    describe "#wound" do
      it "decreases shield, then health" do
        @robot.wound(40)
        expect(@robot.shield).to eq(10)
        expect(@robot.health).to eq(100)
      end

      it "doesn't decrease shield below 0" do
        @robot.wound(60)
        expect(@robot.shield).to eq(0)
      end
    end
  end

end
