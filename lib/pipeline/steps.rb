require "concurrent"

module Pipeline
  class StepError < StandardError
  end

  class TypeError < StandardError
  end

  require_relative "step"
  require_relative "parallel"
end
