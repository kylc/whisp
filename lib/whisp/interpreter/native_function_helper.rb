module Whisp
  module Interpreter
    class NativeFunctionHelper
      def initialize(interpreter)
        @interpreter = interpreter
      end

      def evaluate_arguments(args)
        args.map! { |arg| @interpreter.evaluate(arg) }
      end
    end
  end
end
