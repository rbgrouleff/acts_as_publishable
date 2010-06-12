# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{acts_as_publishable}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Rasmus Bang Grouleff"]
  s.date = %q{2010-06-12}
  s.description = %q{Rails gem that adds functionality to make Active Record models publishable}
  s.email = %q{rasmus@anybite.com}
  s.extra_rdoc_files = ["README.rdoc", "lib/acts_as_publishable.rb", "lib/acts_as_publishable/acts_as_publishable.rb"]
  s.files = ["README.rdoc", "Rakefile", "lib/acts_as_publishable.rb", "lib/acts_as_publishable/acts_as_publishable.rb", "Manifest", "acts_as_publishable.gemspec"]
  s.homepage = %q{http://github.com/rbgrouleff/acts_as_publishable}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Acts_as_publishable", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{acts_as_publishable}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Rails gem that adds functionality to make Active Record models publishable}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
