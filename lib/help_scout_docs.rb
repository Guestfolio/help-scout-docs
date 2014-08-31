require 'log4r'
require 'help_scout_docs/configurable'
require 'help_scout_docs/error/errors'
require 'help_scout_docs/client'
require 'help_scout_docs/methods/methods'
require 'help_scout_docs/result'

module HelpScoutDocs
  class << self
    include HelpScoutDocs::Configurable
  end
end

HelpScoutDocs.setup
