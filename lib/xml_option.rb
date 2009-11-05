
require 'nokogiri'

module XmlOption
  module_function
  def from_file_path path
    XmlOption.from_string(File.read(path))
  end

  def from_io io
    XmlOption.from_string(io.read)
  end

  def from_string string
    XmlOption.parse(Nokogiri::XML.parse(string).root)
  end

  def parse elem, parent = nil
    if elem.children.empty? && parent
      (parent[elem.name] ||= []) <<
        Hash[elem.attributes.values.map{ |attr| [attr.name, attr.value] }]

    else
      result = {elem.name => hash = {}}
      elem.children.map{ |child|
        XmlOption.parse(child, hash) if child.kind_of?(Nokogiri::XML::Element)
      }.compact
      result
    end

  end
end # of XmlOption
