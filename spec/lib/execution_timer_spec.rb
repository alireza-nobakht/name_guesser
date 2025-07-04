# frozen_string_literal: true

require "rails_helper"

RSpec.describe ExecutionTimer do
  describe ".measure" do
    it "returns the time elapsed for the block execution (float rounded to 5 decimals)" do
      duration = ExecutionTimer.measure do
        sleep 0.01
      end

      expect(duration).to be_a(Float)
      expect(duration).to be >= 0.01
      expect(duration.round(5)).to eq(duration) # already rounded to 5 decimals
    end

    it "returns near zero for an empty block" do
      duration = ExecutionTimer.measure do
        # do nothing
      end

      expect(duration).to be >= 0.0
      expect(duration).to be < 0.01
    end
  end
end
