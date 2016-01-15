require_relative '../dynamical_system'
require 'minitest/autorun'

class TestDynamicalSystemClass < Minitest::Test

  def setup
    @rule = { :s1 => :s2, :s2 => :s1, :s3 => :s3 }
    @sys = DynamicalSystem.new(@rule, :s1)
  end

  def test_initialization
    assert_instance_of(DynamicalSystem, DynamicalSystem.new(@rule, :s1))
  end

  def test_is_valid_rule?
    @rule = 0 #not a Hash
    assert_equal(DynamicalSystem.is_valid_rule?(@rule), false)

    @rule = { :s1 => :s2, :s3 => :s3 } #undefined on :s2
    assert_equal(DynamicalSystem.is_valid_rule?(@rule), false)
  end

  def test_random
    random_sys = DynamicalSystem.random(5)
    assert_instance_of(DynamicalSystem, random_sys)
    assert_equal(5, random_sys.states.size)
  end
end

