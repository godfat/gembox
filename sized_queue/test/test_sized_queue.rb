# encoding: utf-8

TestCase = begin
             require 'minitest/unit'
             MiniTest::Unit.autorun
             MiniTest::Unit::TestCase
           rescue LoadError
             require 'test/unit'
             Test::Unit::TestCase
           end

require 'sized_queue'
require 'yaml'

class SizedQueueTest < TestCase
  def test_sized_queue
    q = SizedQueue.new(5)

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

    assert_kind_of SizedQueue, q.enqueue
  end

  def test_yaml
    q = SizedQueue.new(29)
    q.enqueue(*(0..30).to_a)
    assert_equal((2..30).to_a.reverse, q.data)
    assert_equal q, YAML.load(YAML.dump(q))
    assert_equal q.data, YAML.load(YAML.dump(q)).data
  end
end
