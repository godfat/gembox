# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sized_q}
  s.version = "0.9.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Lin Jen-Shin (aka godfat 真常)"]
  s.date = %q{2009-11-28}
  s.description = %q{}
  s.email = %q{godfat (XD) godfat.org}
  s.extra_rdoc_files = ["CHANGES", "README", "Rakefile"]
  s.files = ["CHANGES", "README", "Rakefile", "lib/sized_q.rb", "lib/sized_q/version.rb", "test/test_sized_q.rb"]
  s.homepage = %q{http://github.com/godfat/gembox}
  s.rdoc_options = ["--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{ludy}
  s.rubygems_version = %q{1.3.5}
  s.summary = nil
  s.test_files = ["test/test_sized_q.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bones>, [">= 3.1.0"])
    else
      s.add_dependency(%q<bones>, [">= 3.1.0"])
    end
  else
    s.add_dependency(%q<bones>, [">= 3.1.0"])
  end
end
