# frozen_string_literal: true

class GuessCountry
  def initialize(name, timer: Container.resolve("execution_timer"))
    @name = name
    @timer = timer
  end

  def call
    result = nil

    time_taken = @timer.measure do
      countries = CountryLookup.call(name: @name)
      result = Decorator::Country.call(countries || [])
    end

    {
      guessed_country: result,
      requested_name: @name,
      time_processed: "#{'%.5f' % time_taken}s"
    }
  end
end
