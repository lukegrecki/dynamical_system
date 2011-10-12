require 'set'

class System
  attr_reader :state, :states, :history

  def self.is_valid_rule?(rule)
    return (rule.is_a?(Hash) &&
            rule.values.to_set.subset?(rule.keys.to_set)) ? true : false
  end

  def is_valid_state?(state)
    return @states.include?(state) ? true : false
  end

  def inspect
    puts "state : #{@state}\n" + "history : #{history}\n" +
         "rule : #{@rule}\n" + "states : #{@states}"
  end

  def initialize(rule, initial_state)
    if System.is_valid_rule?(rule)
      @rule = rule
      @states = rule.keys
      if is_valid_state?(initial_state)
        @state = initial_state
        @history = [initial_state]
      else
        raise StateError
      end
    else
      raise RuleError
    end
  end

  def state=(new_state)
    if is_valid_state?(new_state)
      @state = new_state
      @history = [@state]
    else
      raise StateError
    end
  end

  def evolve!(steps = 1, state = @state)
    set_state(state) if state != @state
    steps.times { @state = @rule[@state]; @history << @state }
    return @state
  end

  def evolve(steps = 1, state = @state)
    if is_valid_state?(state)
      steps.times { state = @rule[state] }
      return state
    else
      raise StateError
    end
  end

  def orbit!(steps = 1, state = @state)
    set_state(state) if state != @state
    orbit = [@state]
    steps.times { @state = @rule[@state]; @history << @state; orbit << @state }
    return orbit
  end

  def orbit(steps = 1, state = @state)
    orbit = [state]
    steps.times { state = @rule[state]; orbit << state }
    return orbit
  end

  def is_fixed_point?(state = @state)
    if is_valid_state?(state)
      return state == evolve(1, state) ? true : false
    else
      raise StateError
    end
  end

  def fixed_points
    @fixed_points ||= @states.select { |s| is_fixed_point?(s) }
  end

  def is_invariant_set?(state_array)
    new_state_array = state_array.map { |s| evolve(1, s) }
    return new_state_array.to_set == state_array.to_set ? true : false
  end

  alias :set_state :state=
end

class StateError < StandardError; end
class RuleError < StandardError; end

