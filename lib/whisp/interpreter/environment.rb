module Whisp
  module Interpreter
    # An environment represents the current state of the bindings within the
    # language.  There are multiple environments within a single script.  For
    # instance, all local bindings are stored in a local environment, which has
    # a parent.  Each environment has a parent until the root node is reached.
    class Environment
      DEFAULT_ENVIRONMENT = {
        :"#t" => true,
        :"#f" => false
      }

      def initialize(parent = nil)
        @parent = parent
        @table = DEFAULT_ENVIRONMENT.clone
      end

      # Get the value bound to the provided +name+.  This will search the
      # current environment's table and its parent's table.  If neither have the
      # value we are looking for, +nil+ is returned.
      def get(name)
        return @table[name] if @table.has_key?(name)
        return @parent.get(name) unless @parent.nil?
        return nil
      end

      def put(name, value)
        @table[name] = value
      end

      def has_key?(name)
        @table.has_key?(name)
      end
    end
  end
end
