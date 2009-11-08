# encoding: utf-8

TestCase = begin
             require 'minitest/unit'
             MiniTest::Unit.autorun
             MiniTest::Unit::TestCase
           rescue LoadError
             require 'test/unit'
             Test::Unit::TestCase
           end

require 'key_diff'
require 'yaml'

class KeyDiffTest < TestCase
  def test_key_diff
    a, b = ['test/en.yaml', 'test/zh.yaml']
    extract = lambda{ |path| YAML.load(File.read(path))[File.basename(path).split('.')[0]] }
    aa, bb = KeyDiff.diff( extract[a], extract[b] )

    assert_equal ['animal.mammal.monkey: "猴子"'], aa
    assert_equal ['animal.bird: "bird"', 'mineral: "mineral"'], bb
  end
end
