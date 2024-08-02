# frozen_string_literal: true

# Copyright (c) 2024 Yegor Bugayenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

require 'minitest/autorun'
require_relative '../../test__helper'
require_relative '../../../lib/factbase/terms'

# Math test.
# Author:: uchitsa (uchitsa@ya.ru)
# Copyright:: Copyright (c) 2024 Yegor Bugayenko
# License:: MIT

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