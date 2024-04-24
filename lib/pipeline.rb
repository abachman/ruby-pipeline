require_relative "pipeline/steps"
require_relative "pipeline/version"

module Pipeline
  class Error < StandardError; end

  def self.create(elements)
    Pipeline.new(elements)
  end

  class Pipeline
    def initialize(elements)
      @elements = elements
    end

    def call(input)
      # equivalent to:
      #   elements[2].call(
      #     elements[1].call(
      #       elements[0].call(input)
      #     )
      #   )
      #
      # or:
      #   elements[0].call(input)
      #     .then { elements[1].call _1 }
      #     .then { elements[2].call _1 }
      #
      elements.reduce(input) do |memo, element|
        element.call(memo)
      end
    end

    private

    attr_reader :elements
  end
end
