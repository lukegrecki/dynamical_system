A simple ruby library for discrete dynamical systems.
-----------------------------------------------------

The essence of each system is a rule (given as a hash) that determines state transitions. You can create, evolve, and toy with these systems in a variety of ways.

    require_relative 'dynamical_system'

    # A cyclic system with 3 states

    rule = { :s1 => :s2, :s2 => :s3, :s3 => :s1 }
    sys = DynamicalSystem.new(rule, :s1)

    sys.states      # => [:s1, :s2, :s3]
    sys.evolve!(6)  # => :s1
    sys.history     # => [:s1, :s2, :s3, :s1, :s2, :s3, :s1]

Check out 'examples.rb' for more.

