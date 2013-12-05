
require 'nokogiri'
require 'time'
require 'cgi'

module Plist
  module_function # PARSE
  def parse xml
    return {} if xml.strip.empty?
    decode(Nokogiri::XML.parse(xml, nil, nil,
             Nokogiri::XML::ParseOptions::STRICT |
             Nokogiri::XML::ParseOptions::NOBLANKS).root.children.first)
  rescue Nokogiri::XML::SyntaxError
    {}
  end

  def decode element
    case element.name
    when 'dict'   ; decode_dict( element)
    when 'array'  ; decode_array(element)
    when 'integer'; element.inner_text.to_i
    when 'real'   ; element.inner_text.to_f
    when 'date'   ; Time.parse(element.inner_text)
    when 'false'  ; false
    when 'true'   ; true
    when 'string' ; element.inner_text
    when 'data'   ; element.inner_text
    end
  end

  def decode_dict dict
    dict.xpath('./key').inject({}){ |r, key|
      r[key.inner_text] = decode(key.next_element)
      r
    }
  end

  def decode_array array
    array.children.map{ |child| decode(child) }.compact
  end

  module_function # DUMP

  HEADER = <<-XML.strip
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
  XML

  Key = Class.new(String) # internal key type

  def dump obj
    wrap{ encode(obj).strip }
  end

  def encode obj, level=0
    return '' if obj.nil?

    ele = case obj
          when Hash          ; encode_hash( obj, level)
          when Array         ; encode_array(obj, level)
          when Integer       ; "<integer>#{obj}</integer>"
          when Float         ; if obj.zero?
                                 "<integer>0</integer>"
                               else
                                 "<real>#{obj}</real>"
                               end
          when Time          ; encode_date(obj.utc)
          when Date          ; encode_date(obj)
          when TrueClass     ; "<true/>"
          when FalseClass    ; "<false/>"
          when Key           ; "<key>#{escape(obj)}</key>"
          when String, Symbol; "<string>#{escape(obj)}</string>"
          else raise "What's this? #{obj}"
          end
    "#{indent(level)}#{ele}\n"
  end

  def encode_hash hash, level=0
    "<dict>\n#{hash.map{ |k, v|
      "#{encode(Key.new(k), level + 1) unless v.nil?}" \
      "#{encode(v, level + 1)}" }.
      join}#{indent(level)}</dict>"
  end

  def encode_array array, level=0
    "<array>\n#{array.map{ |ele|
      encode(ele, level + 1) }.join}#{indent(level)}</array>"
  end

  def encode_date time
    "<date>#{time.strftime('%Y-%m-%dT%H:%M:%SZ')}</date>"
  end

  def indent level
    "\t" * level
  end

  def escape s
    CGI.escape_html(s)
  end

  def wrap
    %Q{#{HEADER}\n<plist version="1.0">\n#{yield}\n</plist>\n}
  end
end

if $PROGRAM_NAME == __FILE__
  require 'bacon'
  Bacon.summary_on_exit
  describe Plist do
    should 'parse and dump' do
      plist = DATA.read
      hash  = Plist.parse(plist)
      time  = Time.parse('2013-12-06T06:37:28Z')
      Plist.dump(hash)                  .should.eql     plist
      hash                              .should.kind_of Hash
      hash['bundles']                   .should.kind_of Array
      hash['bundles'][0]                .should.kind_of Hash
      hash['bundles'][0]['bool']        .should.eql     true
      hash['bundles'][0]['integer']     .should.eql     0
      hash['bundles'][0]['string']      .should.eql     'something'
      hash['bundles'][0]['array']       .should.kind_of Array
      hash['bundles'][0]['array'][0]    .should.eql     'element'
      hash['bundles'][0]['array'][1]    .should.eql     1.1
      hash['bundles'][0]['array'][2]    .should.eql     false
      hash['bundles'][0]['dict']        .should.kind_of Hash
      hash['bundles'][0]['dict']['time'].should.kind_of Time
      hash['bundles'][0]['dict']['time'].should.eql     time
    end
  end
end

__END__
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>bundles</key>
	<array>
		<dict>
			<key>bool</key>
			<true/>
			<key>integer</key>
			<integer>0</integer>
			<key>string</key>
			<string>something</string>
			<key>array</key>
			<array>
				<string>element</string>
				<real>1.1</real>
				<false/>
			</array>
			<key>dict</key>
			<dict>
				<key>time</key>
				<date>2013-12-06T06:37:28Z</date>
			</dict>
		</dict>
	</array>
</dict>
</plist>
