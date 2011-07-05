(def +
  (native "
    lambda do |args, interpreter|
      args.reduce(:+)
    end
  ")
)

(def -
  (native "
    lambda do |args, interpreter|
      args.reduce(:-)
    end
  ")
)

(def *
  (native "
    lambda do |args, interpreter|
      args.reduce(:*)
    end
  ")
)

(def /
  (native "
    lambda do |args, interpreter|
      args.reduce(:/)
    end
  ")
)
