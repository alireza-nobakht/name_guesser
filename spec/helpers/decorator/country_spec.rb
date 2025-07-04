

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Decorator::Country do
  describe '.call' do
    context 'when given valid country data' do
      let(:input) do
        [
          { "country_id" => "DE", "probability" => 0.254 },
          { "country_id" => "FR", "probability" => 0.128 }
        ]
      end

      it 'returns decorated countries with percentage strings' do
        result = described_class.call(input)

        expect(result).to eq([
          { country_id: "DE", probability_percent: "25.4%" },
          { country_id: "FR", probability_percent: "12.8%" }
        ])
      end
    end

    context 'when input is nil' do
      it 'returns an empty array' do
        expect(described_class.call(nil)).to eq([])
      end
    end

    context 'when input is not an array' do
      it 'returns an empty array' do
        expect(described_class.call("invalid")).to eq([])
      end
    end
  end
end
