# frozen_string_literal: true

class CountryLookup
  def self.call(**args)
    adapter = Container.resolve("adapter")
    unless adapter.respond_to?(:call)
      raise ArgumentError, "Adapter must respond to .call"
    end
    adapter.call(**args)
  end
end
