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

class SizedQueueTest < TestCase
  def test_sized_queue
    assert true
  end
end
