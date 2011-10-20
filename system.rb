require 'set'

class System
  attr_reader :state, :states, :history

  def self.is_valid_rule?(rule)
    return (rule.is_a?(Hash) &&
            rule.values.to_set.subset?(rule.keys.to_set)) ? true : false
  end

  def self.random(number_of_states)
    rule = {}
    (1..number_of_states).each do |s|
      r = rand(number_of_states) + 1
      rule.merge!({ "s#{s}".to_sym => "s#{r}".to_sym })
    end
    return self.new(rule, :s1)
  end

  def inspect
    puts "state : #{@state}\n" + "history : #{history}\n" +
         "rule : #{@rule}\n" + "states : #{@states}"
  end

  def initialize(rule, initial_state)
    if System.is_valid_rule?(rule)
      @rule = rule
      @states = rule.keys
      @state = initial_state
      @history = [initial_state]
    else
      raise RuleError
    end
  end

  def state=(new_state)
    @state = new_state
    @history = [@state] #resets history
  end

  def evolve!(steps = 1, state = @state)
    set_state(state) if state != @state
    steps.times { @state = @rule[@state]; @history << @state }
    return @state
  end

  def evolve(steps = 1, state = @state)
    steps.times { state = @rule[state] }
    return state
  end

  def path!(steps = 1, state = @state)
    set_state(state) if state != @state
    path = [@state]
    steps.times { @state = @rule[@state]; @history << @state; path << @state }
    return path
  end

  def path(steps = 1, state = @state)
    path = [state]
    steps.times { state = @rule[state]; path << state }
    return path
  end

  def forward_orbit(state = @state)
    forward_orbit = [state]
    new_state = @rule[state]
    until forward_orbit.include?(new_state) do
      forward_orbit << new_state
      new_state = @rule[new_state]
    end
    forward_orbit << new_state #needed to see the cycle
    return forward_orbit
  end

  def backward_orbit(state = @state)
    raise RuleError, "Is not bijective" unless is_bijective?
    backward_orbit = [state]
    old_state = @rule.key(state)
    until backward_orbit.include?(old_state) do
      backward_orbit << old_state
      old_state = @rule.key(old_state)
    end
    backward_orbit << old_state #needed to see the cycle
    return backward_orbit
  end

  def orbit(state = @state)
    raise RuleError, "Is not bijective" unless is_bijective?
    return backward_orbit(state)[0...-1] += (forward_orbit(state))
  end

  def is_fixed_point?(state = @state)
    return state == evolve(1, state) ? true : false
  end

  def fixed_points
    @fixed_points ||= @states.select { |s| is_fixed_point?(s) }
  end

  def is_invariant_set?(state_array)
    new_state_array = state_array.map { |s| evolve(1, s) }
    return new_state_array.to_set == state_array.to_set ? true : false
  end

  def is_bijective?
    return @states.size == @rule.values.uniq.size
  end

  alias :set_state :state=
end

class StateError < StandardError; end
class RuleError < StandardError; end

