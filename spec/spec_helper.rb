$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')

require 'rubygems'
require 'bundler/setup'

require 'active_record'
require 'acts_as_publishable'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
