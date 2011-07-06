(def fn
  (native "
    lambda do |args, interpreter|
      function_args = args[0]
      function_expressions = args[1]

      lambda do |args, interpreter|
        evaluate_arguments(args)

        if args.length != function_args.length
          raise InterpreterError, 'Argument error: got ' + args.length.to_s +
              ' but expected ' + function_args.length.to_s
        end

        function_args.zip(args) do |arg_name, arg_value|
          # TODO: use a local environment
          interpreter.root_environment.put(arg_name, arg_value)
        end

        interpreter.evaluate(function_expressions)
      end
    end
  ")
)
