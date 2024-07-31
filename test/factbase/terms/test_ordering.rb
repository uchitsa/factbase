require 'minitest/autorun'
require_relative '../../test__helper'
require_relative '../../../lib/factbase/terms'

class TestFactbaseTermOrdering < Minitest::Test
  def setup
    @term = Factbase::Term::Ordering.new
  end

  def test_prev_with_single_value
    fact = { foo: 42 }
    maps = []

    assert_nil @term.prev(fact, maps)
    assert_equal 42, @term.prev(fact, maps)
    assert_equal 42, @term.prev(fact, maps)
  end

  def test_prev_with_multiple_values
    fact1 = { foo: 42 }
    fact2 = { foo: 43 }
    maps = []

    assert_nil @term.prev(fact1, maps)
    assert_equal 42, @term.prev(fact1, maps)
    assert_equal 42, @term.prev(fact1, maps)
    assert_equal 42, @term.prev(fact2, maps)
    assert_equal 43, @term.prev(fact2, maps)
  end

  def test_unique_with_single_value
    fact = { foo: 42 }
    maps = []

    assert @term.unique(fact, maps)
    refute @term.unique(fact, maps)
  end

  def test_unique_with_multiple_values
    fact1 = { foo: 42 }
    fact2 = { foo: 43 }
    fact3 = { foo: 42 }
    maps = []

    assert @term.unique(fact1, maps)
    assert @term.unique(fact2, maps)
    refute @term.unique(fact3, maps)
  end

  def test_unique_with_array_values
    fact1 = { foo: [42, 43] }
    fact2 = { foo: [43, 44] }
    maps = []

    assert @term.unique(fact1, maps)
    assert @term.unique(fact2, maps)
    refute @term.unique(fact1, maps)
  end

  def test_unique_with_nil_value
    fact = { foo: nil }
    maps = []

    refute @term.unique(fact, maps)
  end

  def test_unique_with_empty_array
    fact = { foo: [] }
    maps = []

    assert @term.unique(fact, maps)
  end
end