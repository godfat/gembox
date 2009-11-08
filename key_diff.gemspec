# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{key_diff}
  s.version = "0.9.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["godfat"]
  s.date = %q{2009-11-08}
  s.default_executable = %q{rlang_diff}
  s.description = %q{ Help you diff keys in two hashes.}
  s.email = %q{godfat@godfat.org}
  s.executables = ["rlang_diff"]
  s.extra_rdoc_files = ["CHANGES", "README", "bin/rlang_diff", "key_diff.gemspec"]
  s.files = ["CHANGES", "README", "Rakefile", "bin/rlang_diff", "key_diff.gemspec", "lib/key_diff.rb", "lib/key_diff/version.rb", "test/en.yaml", "test/test_key_diff.rb", "test/zh.yaml"]
  s.homepage = %q{http://github.com/godfat/key_diff}
  s.rdoc_options = ["--charset=utf-8", "--inline-source", "--line-numbers", "--promiscuous", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{ludy}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Help you diff keys in two hashes.}
  s.test_files = ["test/test_key_diff.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bones>, [">= 2.5.1"])
    else
      s.add_dependency(%q<bones>, [">= 2.5.1"])
    end
  else
    s.add_dependency(%q<bones>, [">= 2.5.1"])
  end
end
