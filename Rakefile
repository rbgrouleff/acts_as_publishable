require 'rubygems'
require 'rake'
require 'echoe'
  
Echoe.new('acts_as_publishable', '0.1.0') do |p|
  p.description     = "Rails gem that adds functionality to make Active Record models publishable"
  p.url             = "http://github.com/rbgrouleff/acts_as_publishable"
  p.author          = "Rasmus Bang Grouleff"
  p.email           = "rasmus@anybite.com"
  p.ignore_pattern  = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }