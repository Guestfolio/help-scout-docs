ENV['HELP_SCOUT_DOCS_API_KEY'] = "api-key";

require 'help_scout_docs'
require 'webmock'
require 'multi_json'
require 'vcr'
require 'pry'

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = true
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.filter_sensitive_data('<api-key>')      { ENV['HELP_SCOUT_DOCS_API_KEY'] }
  c.filter_sensitive_data('<api-password>') { "X" }
  c.configure_rspec_metadata!
end

Log4r::Logger.global.outputters = Log4r::Outputter.stdout
