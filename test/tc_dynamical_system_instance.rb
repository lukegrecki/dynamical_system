require_relative '../dynamical_system'
require 'minitest/autorun'

class TestDynamicalSystemInstance < Minitest::Test

  def setup
    @rule = { :s1 => :s2, :s2 => :s1, :s3 => :s3 }
    @sys = DynamicalSystem.new(@rule, :s1)
  end

  def test_evolve!
    assert_equal(@sys.evolve!(2, :s2), :s2)
    assert_equal(@sys.state, :s2)
    assert_equal(@sys.history, [:s2, :s1, :s2])
  end

  def test_evolve
    assert_equal(@sys.evolve(2, :s2), :s2)
    assert_equal(@sys.state, :s1)
  end

  def test_path!
    assert_equal(@sys.path!(2, :s2), [:s2, :s1, :s2])
    assert_equal(@sys.state, :s2)
    assert_equal(@sys.history, [:s2, :s1, :s2])
  end

  def test_path
    assert_equal(@sys.path(2, :s2), [:s2, :s1, :s2])
    assert_equal(@sys.state, :s1)
  end

  def test_forward_orbit
    @rule.merge!({ :s2 => :s4, :s4 => :s2 })
    @sys = DynamicalSystem.new(@rule, :s1)
    assert_equal(@sys.forward_orbit(:s1), [:s1, :s2, :s4, :s2])
  end

  def test_backward_orbit
    assert_equal(@sys.backward_orbit, [:s1, :s2, :s1])
    assert_equal(@sys.backward_orbit(:s3), [:s3, :s3])
  end

  def test_orbit
    assert_equal(@sys.orbit, [:s1, :s2, :s1, :s2, :s1])
    assert_equal(@sys.orbit(:s3), [:s3, :s3, :s3])
  end

  def test_cycle_from_forward_orbit
    @rule.merge!({ :s2 => :s4, :s4 => :s2 })
    @sys = DynamicalSystem.new(@rule, :s1)
    forward_orbit = @sys.forward_orbit(:s1)
    assert_equal([:s2, :s4], @sys.cycle_from_forward_orbit(forward_orbit))
  end

  def test_cycles
    @rule.merge!({ :s2 => :s4, :s4 => :s2 })
    @sys = DynamicalSystem.new(@rule, :s1)
    assert_equal(true, [[:s2, :s4], [:s3]].to_set == @sys.cycles.to_set || \
                       [[:s4, :s2], [:s3]].to_set == @sys.cycles.to_set)
  end

  def test_is_fixed_point?
    assert_equal(@sys.is_fixed_point?(:s1), false)
    assert_equal(@sys.is_fixed_point?(:s3), true)
  end

  def test_fixed_points
    @rule = { :s1 => :s2, :s2 => :s1, :s3 => :s3, :s4 => :s4 }
    @sys = DynamicalSystem.new(@rule, :s1)
    assert_equal(@sys.fixed_points.to_set, Set.new([:s3, :s4]))
  end

  def test_is_invariant_set?
    assert_equal(@sys.is_invariant_set?([:s1, :s2]), true)
    assert_equal(@sys.is_invariant_set?([:s1, :s3]), false)
  end

  def test_is_bijective?
    assert_equal(@sys.is_bijective?, true)

    @rule_2 = { :s1 => :s1, :s2 => :s1 }
    @sys_2 = DynamicalSystem.new(@rule_2, :s1)
    assert_equal(@sys_2.is_bijective?, false)
  end
end

