(def puts
  (native "
    lambda do |args, interpreter|
      args.each { |arg| puts interpreter.evaluate(arg) }
    end
  ")
)
