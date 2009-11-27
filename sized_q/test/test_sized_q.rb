# encoding: utf-8

TestCase = begin
             require 'minitest/unit'
             MiniTest::Unit.autorun
             MiniTest::Unit::TestCase
           rescue LoadError
             require 'test/unit'
             Test::Unit::TestCase
           end

require 'sized_q'
require 'yaml'

class SizedQTest < TestCase
  def test_sized_q
    q = SizedQ.new(5)

    q.enqueue :foo
    assert_equal :foo, q.first

    q.enqueue :bar
    assert_equal :bar, q.first

    assert_equal [:bar, :foo], q.to_a

    q.enqueue(*[:a, :b, :c, :d])

    data = [:d, :c, :b, :a, :bar]
    assert_equal data, q.to_a
    q.each_with_index{ |i, index|
      assert_equal data[index], i
    }

    q.enqueue(*(0..9).to_a)
    assert_equal [9, 8, 7, 6, 5], q.to_a

    assert_kind_of SizedQ, q.enqueue
  end

  def test_yaml
    q = SizedQ.new(29)
    q.enqueue(*(0..30).to_a)
    assert_equal((2..30).to_a.reverse, q.to_a)
    assert_equal q, YAML.load(YAML.dump(q))
    assert_equal q.to_a, YAML.load(YAML.dump(q)).to_a
  end
end
