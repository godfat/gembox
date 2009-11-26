# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{xml_option}
  s.version = "0.9.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["godfat"]
  s.date = %q{2009-11-08}
  s.description = %q{ Extract subset of XML and convert it into Ruby Hash.}
  s.email = %q{godfat@godfat.org}
  s.extra_rdoc_files = ["CHANGES", "README"]
  s.files = ["CHANGES", "README", "Rakefile", "lib/xml_option.rb", "lib/xml_option/version.rb", "test/sample0.rb", "test/sample0.xml", "test/sample1.rb", "test/sample1.xml", "test/test_xml_option.rb"]
  s.homepage = %q{http://github.com/godfat/xml_option}
  s.rdoc_options = ["--charset=utf-8", "--inline-source", "--line-numbers", "--promiscuous", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{ludy}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Extract subset of XML and convert it into Ruby Hash.}
  s.test_files = ["test/test_xml_option.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_development_dependency(%q<bones>, [">= 2.5.1"])
    else
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<bones>, [">= 2.5.1"])
    end
  else
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<bones>, [">= 2.5.1"])
  end
end
