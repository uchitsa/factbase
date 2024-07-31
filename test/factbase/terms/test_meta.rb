require 'minitest/autorun'
require 'time'

class TestFactbaseTermMeta < Minitest::Test
  def fact(data)
    data
  end

  def test_exists
    t = Factbase::Term.new(:exists, [:foo])
    assert(t.evaluate(fact('foo' => 'bar'), []))
    assert(!t.evaluate(fact('bar' => 'foo'), []))
  end

  def test_absent
    t = Factbase::Term.new(:absent, [:foo])
    assert(t.evaluate(fact('bar' => 'foo'), []))
    assert(!t.evaluate(fact('foo' => 'bar'), []))
  end

  def test_size
    t = Factbase::Term.new(:size, [:foo])
    assert_equal(0, t.evaluate(fact('foo' => nil), []))
    assert_equal(1, t.evaluate(fact('foo' => 'bar'), []))
    assert_equal(3, t.evaluate(fact('foo' => [1, 2, 3]), []))
  end

  def test_type
    t = Factbase::Term.new(:type, [:foo])
    assert_equal('nil', t.evaluate(fact('foo' => nil), []))
    assert_equal('String', t.evaluate(fact('foo' => 'bar'), []))
    assert_equal('Integer', t.evaluate(fact('foo' => [1]), []))
    assert_equal('Array', t.evaluate(fact('foo' => [1, 2, 3]), []))
  end

  def test_nil
    t = Factbase::Term.new(:nil, [:foo])
    assert(t.evaluate(fact('foo' => nil), []))
    assert(!t.evaluate(fact('foo' => 'bar'), []))
  end

  def test_many
    t = Factbase::Term.new(:many, [:foo])
    assert(t.evaluate(fact('foo' => [1, 2, 3]), []))
    assert(!t.evaluate(fact('foo' => [1]), []))
    assert(!t.evaluate(fact('foo' => nil), []))
  end

  def test_one
    t = Factbase::Term.new(:one, [:foo])
    assert(t.evaluate(fact('foo' => [1]), []))
    assert(!t.evaluate(fact('foo' => [1, 2, 3]), []))
    assert(!t.evaluate(fact('foo' => nil), []))
  end
end