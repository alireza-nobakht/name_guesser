# frozen_string_literal: true

class Container
  extend Dry::Container::Mixin

  register "execution_timer", ExecutionTimer
  register "adapter", Adapter::NationalizeLookup
end
