(def if
  (native "
    lambda do |args, interpreter|
      if interpreter.evaluate(args[0])
        interpreter.evaluate(args[1])
      else
        interpreter.evaluate(args[2]) unless args[2].nil?
      end
    end
  ")
)
