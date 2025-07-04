# frozen_string_literal: true

module Adapter
  class NationalizeLookup
    extend Interface::CountryLookup
    include HTTParty

    base_uri "https://api.nationalize.io"

    def self.call(name:)
      response = get("/", query: { name: name })
      return nil unless response.success?

      response.parsed_response["country"]
    end
  end
end
