require_relative '../system'
require 'test/unit'

class Test_System < Test::Unit::TestCase

  def setup
    @rule = { :s1 => :s2, :s2 => :s1, :s3 => :s3 }
    @sys = System.new(@rule, :s1)
  end

  def teardown
  end

  def test_is_valid_rule?
    @rule = 0 #not a Hash
    assert_equal(System.is_valid_rule?(@rule), false)

    @rule = { :s1 => :s2, :s3 => :s3 } #undefined on :s2
    assert_equal(System.is_valid_rule?(@rule), false)
  end

  def test_random
    random_sys = System.random(5)
    assert_instance_of(System, random_sys)
    assert_equal(5, random_sys.states.size)
  end

  def test_is_valid_state?
    state = 1 #not in state set
    assert_raise(StateError) { @sys.is_valid_state?(state) }
  end

  def test_initialization
    assert_instance_of(System, System.new(@rule, :s1))
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
    assert_equal(@sys.forward_orbit, [:s1, :s2, :s1])
    assert_equal(@sys.forward_orbit(:s3), [:s3, :s3])
  end

  def test_backward_orbit
    assert_equal(@sys.backward_orbit, [:s1, :s2, :s1])
    assert_equal(@sys.backward_orbit(:s3), [:s3, :s3])
  end

  def test_orbit
    assert_equal(@sys.orbit, [:s1, :s2, :s1, :s2, :s1])
    assert_equal(@sys.orbit(:s3), [:s3, :s3, :s3])
  end

  def test_is_fixed_point?
    assert_equal(@sys.is_fixed_point?(:s1), false)
    assert_equal(@sys.is_fixed_point?(:s3), true)
  end

  def test_fixed_points
    @rule = { :s1 => :s2, :s2 => :s1, :s3 => :s3, :s4 => :s4 }
    @sys = System.new(@rule, :s1)
    assert_equal(@sys.fixed_points.to_set, Set.new([:s3, :s4]))
  end

  def test_is_invariant_set?
    assert_equal(@sys.is_invariant_set?([:s1, :s2]), true)
    assert_equal(@sys.is_invariant_set?([:s1, :s3]), false)
  end

  def test_is_bijective?
    assert_equal(@sys.is_bijective?, true)

    @rule_2 = { :s1 => :s1, :s2 => :s1 }
    @sys_2 = System.new(@rule_2, :s1)
    puts @rule_2.values.size
    assert_equal(@sys_2.is_bijective?, false)
  end
end

