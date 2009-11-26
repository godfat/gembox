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

    monkey = RUBY_VERSION >= '1.9.1' ? '猴子' : '\347\214\264\345\255\220'

    assert_equal ['animal.mammal.monkey: "'+monkey+'"'], aa
    assert_equal ['animal.bird: "bird"', 'mineral: "mineral"'], bb
  end
end
