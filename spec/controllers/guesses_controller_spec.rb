# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GuessesController', type: :request do
  describe 'GET /country_guess' do
    let(:url) { '/country_guess' }

    context 'when name param is present and countries are returned' do
      before do
        allow(CountryLookup).to receive(:call).with(name: 'Müller').and_return([
          { "country_id" => "DE", "probability" => 0.25 },
          { "country_id" => "AT", "probability" => 0.15 }
        ])
      end

      it 'returns 200 with decorated country data' do
        get url, params: { name: 'Müller' }

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)

        expect(json["requested_name"]).to eq("Müller")
        expect(json["guessed_country"]).to be_an(Array)
        expect(json["guessed_country"]).to include(
          { "country_id" => "DE", "probability_percent" => "25.0%" },
          { "country_id" => "AT", "probability_percent" => "15.0%" }
        )
        expect(json["time_processed"]).to match(/s\z/)
      end
    end

    context 'when name param is missing' do
      it 'returns 400 with error message' do
        get url

        expect(response).to have_http_status(:bad_request)
        json = JSON.parse(response.body)

        expect(json).to include("error")
      end
    end

    context 'when adapter returns nil (e.g., failed request)' do
      before do
        allow(CountryLookup).to receive(:call).with(name: 'FailCase').and_return(nil)
      end

      it 'returns 200 with empty guessed_country' do
        get url, params: { name: 'FailCase' }

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)

        expect(json["guessed_country"]).to eq([])
      end
    end
  end
end
