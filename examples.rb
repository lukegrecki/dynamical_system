require_relative 'system'

# A cyclic system with 3 states

rule = { :s1 => :s2, :s2 => :s3, :s3 => :s1 }
sys = System.new(rule, :s1)

sys.states      # => [:s1, :s2, :s3]
sys.evolve!(6)  # => :s1
sys.history     # => [:s1, :s2, :s3, :s1, :s2, :s3, :s1]

# A system with a cycle and a fixed point

rule = { :s1 => :s2, :s2 => :s1, :s3 => :s3 }
sys = System.new(rule, :s1)

sys.fixed_points                  # => [:s3]
sys.is_invariant_set?([:s1, :s2]) # => true

# A system with a single attractor

rule = { :s1 => :s3, :s2 => :s3, :s3 => :s3 }
sys = System.new(rule, :s1)

sys.path!(3)            # => [:s1, :s3, :s3, :s3]
sys.is_fixed_point?(:s3) # => true
sys.is_bijective?        # => false

# A random system with 5 states

sys = System.random(5)
sys.states.size # => 5

