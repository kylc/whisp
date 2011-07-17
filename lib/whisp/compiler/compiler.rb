module Whisp
  module Compiler
    class Compiler
      attr_reader :module

      def initialize
        @parser = Parser::Parser.new
      end

      def compile(input)
        expressions = @parser.parse(input)

        @builder = BiteScript::FileBuilder.build(__FILE__)
        @clazz = @builder.public_class "Main" do |clazz|
          clazz.main do |mb|
            expressions.each { |expression| compile_expression(expression, mb) }
          end
        end

        @builder.generate do |filename, class_builder|
          File.open(filename, 'w') do |file|
            file.write(class_builder.generate)
          end
        end
      end

      def compile_expression(expression, builder)
        # Variable lookup
        if expression.is_a? Symbol

        end

        # Expression may be standalone

        if expression[0] == :native # Native function
        elsif expression[0] == :def # Definition
        else # Funtion call
          function_name = expression[0]
          function_arguments = expression.slice(1, expression.length)

          puts function_name

          if @clazz.methods.include? function_name.to_s
            builder.invokestatic @clazz, function_name, [Java::void]
          elsif function_name == :println
            function_arguments.each do |argument|
              builder.ldc argument
              builder.aprintln
              builder.returnvoid
            end
          else
            raise "Undefined method #{function_name}"
          end
        end
      end
    end
  end
end
