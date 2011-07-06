(def eq
  (native "
    lambda do |args, interpreter|
      evaluate_arguments(args)

      first = args[0]
      args.slice(1, args.length).all? { |x| x == first }
    end
  ")
)

(def <
  (native "
    lambda do |args, interpreter|
      evaluate_arguments(args)

      args[0] < args[1]
    end
  ")
)

(def >
  (native "
    lambda do |args, interpreter|
      evaluate_arguments(args)

      args[0] > args[1]
    end
  ")
)
