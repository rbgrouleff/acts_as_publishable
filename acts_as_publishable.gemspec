# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "acts_as_publishable/version"

Gem::Specification.new do |s|
  s.name = %q{acts_as_publishable}
  s.version = ActsAsPublishable::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors = ["Rasmus Bang Grouleff"]
  s.email = %q{rasmus@anybite.com}
  s.homepage = %q{http://github.com/rbgrouleff/acts_as_publishable}
  s.summary = %q{Rails gem that adds functionality to make Active Record models publishable}
  s.description = %q{Rails gem that adds functionality to make Active Record models publishable}

  s.rubyforge_project = %q{acts_as_publishable}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec', '= 1.3.1'
  s.add_development_dependency 'sqlite3-ruby'
  s.add_dependency 'rails', '~> 2.3'
end
