require 'faraday'
require 'faraday/request/multipart'
require 'help_scout_docs/configurable'
require 'help_scout_docs/response/parse_json'
require 'help_scout_docs/version'

module HelpScoutDocs
  module Default
#     Faraday.default_adapter = :net_http_persistent

    ENDPOINT = 'https://docsapi.helpscout.net/v1/'
    MIDDLEWARE = Faraday::Builder.new do |builder|
      # Encode request params as "www-form-urlencoded"
      builder.use Faraday::Request::UrlEncoded
      # Parse JSON response bodies
      builder.use HelpScoutDocs::Response::ParseJson#, content_type: /\bjson$/
      # Use Faraday logger
      builder.use Faraday::Response::Logger if ENV['DEBUG']
      # Set Faraday's HTTP adapter
      builder.adapter Faraday.default_adapter
    end

    class << self

      # @return [Hash]
      def options
        Hash[HelpScoutDocs::Configurable.keys.map{|key| [key, send(key)]}]
      end

      # @return [String]
      def api_key
        ENV['HELP_SCOUT_DOCS_API_KEY']
      end

      # @return [String]
      def api_password
        ENV['HELP_SCOUT_DOCS_API_PASSWORD'] || "X"
      end

      # @return [String]
      def endpoint
        ENDPOINT
      end

      # @note Faraday's middleware stack implementation is comparable to that of Rack middleware.  The order of middleware is important: the first middleware on the list wraps all others, while the last middleware is the innermost one.
      # @see https://github.com/technoweenie/faraday#advanced-middleware-usage
      # @see http://mislav.uniqpath.com/2011/07/faraday-advanced-http/
      # @return [Faraday::Builder]
      def middleware
        MIDDLEWARE
      end

    end
  end
end
