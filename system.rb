require 'set'

class System
  attr_reader :state, :history

  def initialize(rule, initial_state = nil)
    if is_valid_rule?(rule)
      @rule = rule
      @states = rule.keys.to_set
      if is_valid_state?(initial_state)
        @state = initial_state
        @history = [initial_state]
      else
        raise 'Invalid state'
      end
    else
      raise 'Invalid rule'
    end
  end

  def state=(new_state)
    if is_valid_state?(new_state)
      @state = new_state
      @history = [@state]
    else
      raise 'Invalid state'
    end
  end

  def evolve(steps = 1)
    steps.times { @state = @rule[@state]; @history << @state }
    return @state
  end

  def ghost_evolve(ghost_state = @state, steps = 1)
    if is_valid_state?(ghost_state)
      steps.times { ghost_state = @rule[ghost_state] }
      return ghost_state
    else
      raise 'Invalid ghost state'
    end
  end

  def is_fixed_point?(ghost_state = @state)
    if is_valid_state?(ghost_state)
      return ghost_state == self.ghost_evolve(ghost_state) ? true : false
    else
      raise 'Invalid ghost state'
    end
  end

  def fixed_points
    fixed_points = @states.select { |s| is_fixed_point?(s) }.to_set
  end

  def is_valid_rule?(rule)
    return (rule.is_a?(Hash) &&
            rule.keys.to_set == rule.values.to_set) ? true : false
  end

  def is_valid_state?(state)
    return @states.include?(state) ? true : false
  end

end

