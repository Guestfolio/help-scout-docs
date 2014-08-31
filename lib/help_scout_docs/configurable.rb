require 'forwardable'
require 'help_scout_docs/default'

module HelpScoutDocs
  module Configurable
    extend Forwardable
    attr_accessor :api_key, :api_password, :endpoint, :middleware
    def_delegator :options, :hash

    class << self

      def keys
        @keys ||= [
          :api_key,
          :api_password,
          :endpoint,
          :middleware
        ]
      end

    end

    # Convenience method to allow configuration options to be set in a block
    #
    def configure
      yield self
      validate_credential_type!
      self
    end

    def reset!
      HelpScoutDocs::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", HelpScoutDocs::Default.options[key])
      end
      self
    end
    alias setup reset!

    # @return [Boolean]
    #
    def credentials?
      credentials.values.all?
    end

    private

    # @return [Hash]
    #
    def credentials
      {
        api_key: @api_key,
        api_password: @api_password
      }
    end

    # @return [Hash]
    #
    def options
      Hash[HelpScoutDocs::Configurable.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
    end

    # Ensures that all credentials set during configuration are of a
    # valid type. Valid types are String and Symbol.
    #
    # @raise [HelpScoutDocs::Error::ConfigurationError] Error is raised when
    #   supplied twitter credentials are not a String or Symbol.
    def validate_credential_type!
      credentials.each do |credential, value|
        next if value.nil?

        unless value.is_a?(String) || value.is_a?(Symbol)
          raise(Error::ConfigurationError, "Invalid #{credential} specified: #{value} must be a string or symbol.")
        end
      end
    end

  end
end
