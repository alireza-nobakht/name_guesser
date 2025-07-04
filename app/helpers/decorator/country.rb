# frozen_string_literal: true

module Decorator
  module Country
    def self.call(countries)
      return [] unless countries.is_a?(Array) && countries.any?

      countries.filter_map do |country|
        unless country.key?("country_id") && country.key?("probability")
          Rails.logger.warn("Skipping invalid country data: #{country.inspect}")
          next
        end

        {
          country_id: country["country_id"],
          probability_percent: "#{(country["probability"] * 100).round(1)}%"
        }
      end
    end
  end
end
