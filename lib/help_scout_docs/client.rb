require 'faraday'
require 'json'

module HelpScoutDocs
  class Client
    attr_reader :format, :logger

    # Initializes a new Client object
    #
    # @param options [Hash]
    # @return [HelpScoutDocs::Client]
    #
    def initialize(options={})
      @logger = options.delete(:logger) || self.class.logger
      HelpScoutDocs::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key] || HelpScoutDocs.instance_variable_get(:"@#{key}"))
      end
    end

    # Perform an HTTP GET request
    #
    # @param action [Array]
    #
    def get(path=nil, params={})
      @path ||= path
      request(:get, params)
    end

    # Perform an HTTP POST request
    #
    # @param action [Array]
    #
    def post(path=nil, params={})
      @path ||= path
      request(:post, params)
    end

    private

    def self.logger
      Log4r::Logger.new("help_scout_docs::client")
    end

    # @return [Boolean]
    #
    def path
      @path || raise(ArgumentError, "Required path missing")
    end

    # @return [Boolean]
    #
    def authentication_params?
      authentication_params.values.all?
    end

    # Add hash of authentication params
    # @return [Hash]
    #
    def authentication_params
      {
        api_key:      @api_key,
        api_password: @api_password
      }
    end

    # Setup the Faraday::Request headers
    #
    def headers
      {
        ACCEPT: "application/json",
        ACCEPT_CHARSET: "utf-8"
      }
    end

    def request(method, params={})
      response = connection.send(method.to_sym, path, params, headers)
      Result.new(response.body) #.force_encoding('utf-8')
    rescue JSON::ParserError => e
      @logger.error "Unable to parse Help Scout Docs API response: #{e.message}"
      @logger.debug response
      raise HelpScoutDocs::Error::ParserError.new e.message
    end

    # Returns a Faraday::Connection object
    #
    # @return [Faraday::Connection]
    #
    def connection
      raise ArgumentError, "Required authentication params missing" unless authentication_params?
      @connection ||= Faraday.new(@endpoint, builder: @middleware).tap do |c|
        c.basic_auth(authentication_params[:api_key], authentication_params[:api_password])
      end
    end
  end
end
