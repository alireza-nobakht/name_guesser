# frozen_string_literal: true

module Interface
  module CountryLookup
    def call(**args)
      raise NotImplementedError, "You must implement the call method"
    end
  end
end
