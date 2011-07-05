module Whisp
  module Parser
    # Alias to Node for shorthand
    Node = Treetop::Runtime::SyntaxNode

    class Node
      def value
        # Disregard this Node if it is a generic leaf (a simple SyntaxNode
        # provided by Treetop; if we care about it, we'll create a custom node
        # to handle it).  Otherwise, preserve its children and map their values.
        # Meaningful Nodes will override this to escape the terminal behavior.
        terminal? ? nil : elements.map(&:value)
      end
    end

    # A script is an Array of Expressions.
    class Script < Node
      def value
        elements.map(&:value)
      end
    end

    # An expression is is either a String, Number, Atom, or List.  
    class Expression < Node
      def value
        data.value
      end
    end

    class String < Node
      def value
        string_value
      end
    end

    class Number < Node
      def value
        text_value.to_i
      end
    end

    class Atom < Node
      def value
        chars.to_sym
      end
    end

    class List < Node
      def value
        # We need to flush out the generic SyntaxNodes, because Treetop inserts
        # a blank Node if nothing is found.  Otherwise, this method would return
        # [nil] for empty lists.

        # If every child of this node is a generic
        if expressions.all? { |e| e.class == Node }
          # This is an empty list
          []
        else
          # Otherwise, this is a list of values
          expressions.map(&:value)
        end
      end
    end
  end
end
