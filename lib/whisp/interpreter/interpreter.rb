module Whisp
  module Interpreter
    class InterpreterError < RuntimeError; end

    class Interpreter
      # TODO: Come up with a method to store local environments as well.  Right
      # now, everything is, essentially, in the global namespace.
      attr_reader :root_environment

      def initialize
        @parser = Parser::Parser.new
        @root_environment = Environment.new
        @native_function_helper = NativeFunctionHelper.new(self)

        load_standard_library
      end

      # Run the provided code, parsing if necessary.
      def interpret(input)
        input = @parser.parse(input) if input.is_a?(String)
        input.each { |e| evaluate(e) }
      end

      def evaluate(expression)
        # If the expression is an atom
        if expression.is_a? Symbol
          # If the atom is bound in the environment
          if @root_environment.has_key?(expression)
            return @root_environment.get(expression)
          # Otherwise throw an unbound variable error
          else
            raise InterpreterError, "Attempted to access unbound variable: " + expression.to_s
          end
        end

        # There are three basic types of code we will have to handle here: a
        # native function, a definition, or a regular method call.

        # This expression can either be a fully evaluated result, i.e. 5, or a
        # nested expression.  We will know that it is nested if it is an array.
        return expression unless expression.is_a? Array

        # Determine which type of code this is
        if expression[0] == :native # Native function
          return eval(expression[1])
        elsif expression[0] == :def # Definition
          @root_environment.put expression[1], evaluate(expression[2])
        else # Function call
          function_name = expression[0]
          function_arguments = expression.slice(1, expression.length)

          # Call the associated Proc object, providing the argument array and a
          # reference back to this interpreter (the Proc has access to the
          # environment, and the ability to evaluate more code).
          if @root_environment.has_key?(function_name)
            native_function = @root_environment.get(function_name)
            @native_function_helper.instance_exec(function_arguments, self, &native_function)
          else
            raise InterpreterError, "Attempted to call undefined method: " + function_name.to_s
          end
        end
      end

      private

      def load_standard_library
        # Standard library stored in PROJECT_ROOT/std/*.ws
        standard_library_pattern = File.join(ROOT_PROJECT_PATH, 'std', '*.ws')

        Dir[standard_library_pattern].each do |standard_library_file|
          File.open(standard_library_file) do |file|
            file_contents = file.read
            interpret(file_contents)
          end
        end
      end
    end
  end
end
