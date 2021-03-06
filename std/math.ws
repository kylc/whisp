(def +
  (native "
    lambda do |args, interpreter|
      evaluate_arguments(args)

      args.reduce(:+)
    end
  ")
)

(def -
  (native "
    lambda do |args, interpreter|
      evaluate_arguments(args)

      args.reduce(:-)
    end
  ")
)

(def *
  (native "
    lambda do |args, interpreter|
      evaluate_arguments(args)

      args.reduce(:*)
    end
  ")
)

(def /
  (native "
    lambda do |args, interpreter|
      evaluate_arguments(args)

      args.reduce(:/)
    end
  ")
)
