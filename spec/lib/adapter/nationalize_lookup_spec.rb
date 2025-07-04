

# frozen_string_literal: true

require "rails_helper"

RSpec.describe Adapter::NationalizeLookup do
  describe ".call" do
    let(:name) { "ali" }

    context "when the API request is successful" do
      let(:response_body) do
        {
          "name" => name,
          "country" => [
            { "country_id" => "IR", "probability" => 0.45 },
            { "country_id" => "PK", "probability" => 0.22 }
          ]
        }
      end

      before do
        stub_request(:get, "https://api.nationalize.io/?name=#{name}")
          .to_return(status: 200, body: response_body.to_json, headers: { 'Content-Type' => 'application/json' })
      end

      it "returns parsed country data" do
        result = described_class.call(name: name)
        expect(result).to be_an(Array)
        expect(result.first).to include("country_id" => "IR", "probability" => 0.45)
      end
    end

    context "when the API request fails" do
      before do
        stub_request(:get, "https://api.nationalize.io/?name=#{name}")
          .to_return(status: 500, body: "", headers: {})
      end

      it "returns nil" do
        expect(described_class.call(name: name)).to be_nil
      end
    end
  end
end
