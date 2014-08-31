# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "help_scout_docs/version"

Gem::Specification.new do |s|
  s.name        = "help-scout-docs"
  s.version     = HelpScoutDocs::VERSION
  s.license     = "MIT"
  s.authors     = ["Mark Edmondson"]
  s.email       = ["mark@guestfolio.com"]
  s.homepage    = %q{https://github.com/Guestfolio/help-scout-docs}
  s.summary     = %q{Integration with Help Scout Docs API}
  s.description = %q{This limited (read-only) Help Scout Docs API integration provides functionality for extracting existing documentation content}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.has_rdoc = true

  s.add_development_dependency "multi_json", "~> 1.8"

  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "webmock", "~> 1.15"
  s.add_development_dependency "vcr", "~> 2.9"
  s.add_development_dependency "json_spec", "~> 1.1"

  s.add_runtime_dependency "log4r", "~> 1.1"
  s.add_runtime_dependency "faraday_middleware", "~> 0.9"
  s.add_runtime_dependency "json", "~> 1.8"
  s.add_runtime_dependency "net-http-persistent",  "~> 2.9"
end
