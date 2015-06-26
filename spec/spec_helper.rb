# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper.rb"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

require 'rspec'
require 'rack/test'
require "rspec/json_expectations"

require 'sinatra'
require './main'

require 'dm-core'
require 'dm-migrations'
require './models/task'

def app
  Sinatra::Application
end

RSpec.configure do |config|
  config.include Rack::Test::Methods

  DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/api-test.db")
  DataMapper.finalize
  Task.auto_migrate!
#  config.treat_symbols_as_metadata_keys_with_true_values = true
#  config.run_all_when_everything_filtered = true
#  config.filter_run :focus
end
