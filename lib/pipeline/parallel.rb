require "concurrent"

module Pipeline
  # Steps::Parallel is a step that runs a sub-pipeline in parallel for each
  # element in the input. It expects an Enumerable as input and returns the
  # same input object as output.
  class Parallel
    include Step

    expect_input Enumerable

    def initialize(steps)
      super()

      @pipeline = Pipeline.new(steps)
      @thread_pool = Concurrent::FixedThreadPool.new(6)
    end

    def call(input)
      input.each do |record|
        @thread_pool.post do
          @pipeline.call(record)
        rescue => e
          puts e.message
          puts "failed parallel pipeline for #{record}"
        end
      end
      @thread_pool.shutdown
      @thread_pool.wait_for_termination

      input
    end
  end
end
