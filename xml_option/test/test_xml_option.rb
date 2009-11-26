
TestCase = begin
             require 'minitest/unit'
             MiniTest::Unit.autorun
             MiniTest::Unit::TestCase
           rescue LoadError
             require 'test/unit'
             Test::Unit::TestCase
           end

require 'xml_option'

class XmlOptionTest < TestCase
  0.upto(1){ |i|
    define_method("test_sample#{i}"){
      assert_xml_option( instance_eval(File.read("test/sample#{i}.rb")),
                                                 "test/sample#{i}.xml")
    }
  }

  def assert_xml_option expected, path
    [ XmlOption.from_file_path(path),
      XmlOption.from_io(File.open(path)),
      XmlOption.from_string(File.read(path)) ].each{ |hash|
        assert_equal(expected, hash)
      }
  end
end
