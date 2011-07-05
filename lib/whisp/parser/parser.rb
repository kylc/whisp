module Whisp
  module Parser
    class ParserError < RuntimeError; end

    class Parser
      def initialize
        # Automatically generated by Treetop
        @parser = WhispParser.new 
      end

      def parse(input)
        tree = @parser.parse(input)

        if tree.nil?
          raise ParserError, @parser.failure_reason
        end

        # Ask for the value of the root Node, which will cascade onto every
        # child.  In the end, we will have a super simple Ruby representation of
        # our input, rather than a gigantic AST.
        tree.value
      end
    end
  end
end