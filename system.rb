require 'set'

class System
  attr_reader :state, :history

  def initialize(rule, initial_state = nil)
    if is_valid?(rule)
      @rule = rule
      @states = rule.keys.to_set
      @state = initial_state
      @history = [initial_state] if @state
    else
      raise 'Rule is not valid'
    end
  end

  def state=(new_state)
    @state = new_state
    @history = [@state]
  end

  def evolve(steps = 1)
    if @state
      steps.times { @state = @rule[@state]; @history << @state }
      return @state
    else
      raise 'Current state is undefined'
    end
  end

  def at_fixed_point?
    if @state == self.evolve
      true
    else
      false
    end
  end

  def is_valid?(rule)
    if (rule.is_a?(Hash) && rule.keys.to_set == rule.values.to_set)
      return true
    else
      return false
    end
  end

end

