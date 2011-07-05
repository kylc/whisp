(def or
  (native "
    lambda do |args, interpreter|
      args.any? { |x| interpreter.evaluate(x) == true }
    end
  ")
)
