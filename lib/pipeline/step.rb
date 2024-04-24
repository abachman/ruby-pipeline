module Pipeline
  # A mixin for definining Pipeline steps.
  #
  #   class MyStep
  #     include Step
  #
  #     expect_input SomeClass
  #
  #     def call(input)
  #       # do something with input, which is guaranteed
  #       # to be an instance of SomeClass
  #     end
  #   end
  #
  module Step
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def expect_input(klass)
        @input_klass = klass
      end

      def call(input)
        if @input_klass && !input.is_a?(@input_klass)
          raise TypeError,
            "input type is incorrect for #{self}. expecred: #{@input_klass}, got: #{input.class}"
        end

        new.call(input)
      end
    end

    # no-op by default
    def call(input)
      input
    end

    def log(message)
      puts "[\e[32m#{self.class}\e[0m] #{message}"
    end
  end
end
