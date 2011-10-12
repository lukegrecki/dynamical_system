require 'set'

class System
  attr_accessor :state

  def initialize(rule, initial_state = nil)
    if is_valid?(rule)
      @rule = rule
      @state = initial_state
    else
      raise 'Rule is not valid'
    end
  end

  def evolve(steps = 1)
    if @state
      steps.times { @state, @rule = @rule.call(@state) }
      return @state, @rule
    else
      raise 'Current state is undefined'
    end
  end

  def is_valid?(rule)
    if rule.is_a?(Proc)
      return true
    else
      return false
    end
  end

end

