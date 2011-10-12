#  def find_cycle(start_state = @state)
#    if is_valid_state?(start_state)
#      cycle = [start_state]
#      ghost_state = ghost_evolve(start_state)
#      while ghost_state != start_state
#        cycle << ghost_state
#        ghost_state = ghost_evolve(ghost_state)
#      end
#      return cycle
#    else
#      raise StateError
#    end
#  end

#  def find_all_cycles
#    cycles = []
#    unvisited_states = Array(@states)
#    until unvisited_states.empty? do
#      start_state = unvisited_states.sample
#      new_cycle = find_cycle(start_state)
#      cycles << new_cycle
#      unvisited_states -= new_cycle
#    end
#    return cycles
#  end

#  def cycles
#    return @cycles if @cycles
#    ghost_state = start_state
#    visited_states = [ghost_state]
#    next_state = ghost_evolve(ghost_state)
#    until visited_states.index(next_state) do
#      visited_states << next_state
#      ghost_state = next_state
#      next_state = ghost_evolve(ghost_state)
#    end

#  def ghost_walk(start_state = @state)
#    if is_valid_state?(start_state)
#      ghost_state = start_state
#      visited_states = [ghost_state]
#      ghost_state = ghost_evolve(ghost_state)
#      until visited_states.index(ghost_state) do
#        visited_states << ghost_state
#        ghost_state = ghost_evolve(ghost_state)
#      end
#      visited_states << ghost_state
#      return visited_states
#    else
#      raise StateError
#    end
#  end

#  def cycles
#    return @cycles if @cycles
#    @cycles = []
#    visited_states = []
#    states_array = Array(@states)
#    until visited_states.size == @states.size do
#      start_state = (states_array - visisted_states).sample
#      lasso = ghost_walk(start_state)
#      visited_states.push(lasso)
#      last_state = lasso.last
#      cycle = lasso[(last_state.index)...(lasso.length)]
#      @cycles << cycle
#    end
#  end

#  def in_cycle?(start_state = @state)
#    if is_valid_state?(start_state)
#      ghost_state = start_state
#      visited_states = [ghost_state]
#      next_state = ghost_evolve(ghost_state)
#      until visited_states.index(next_state) do
#        visited_states << next_state
#        ghost_state = next_state
#        next_state = ghost_evolve(ghost_state)
#      end
#      last_state = next_state
#      return last_state == start_state ? true : false
#    else
#      raise StateError
#    end
#  end

