# frozen_string_literal: true

module ExecutionTimer
  def self.measure
    start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    yield
    end_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    (end_time - start_time).round(5)
  end
end
