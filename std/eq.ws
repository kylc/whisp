(def eq
  (native "
    lambda do |args, interpreter|
      first = args[0]
      args.slice(1, args.length).all? { |x| x == first }
    end
  ")
)

