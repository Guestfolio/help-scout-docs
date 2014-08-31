module HelpScoutDocs
  class Method
    extend Forwardable
    attr_accessor :method, :client, :options

    def initialize(client=nil, options={})
      @options ||= options
      @client = client || initialize_client
    end

    def_delegator :@client, :get, :get_request
    def_delegator :@client, :post, :post_request
    def_delegator :@client, :path

    # Delegate to a HelpScoutDocs::Client
    #
    # @return [HelpScoutDocs::Client]
    #
    def initialize_client
      @client = HelpScoutDocs::Client.new(@options) unless defined?(@client) && @client.hash == @options.hash
      @client
    end

    # Has a client been initialized?
    #
    # @return [Boolean]
    #
    def client?
      !!@client
    end

    private

    # If we're providing the client, the endpoint may need to be reset set
    # @param [Client]
    # @return [Client]
    #
    def set_endpoint(endpoint)
      @client.instance_variable_set("@endpoint", endpoint)
    end

    # Are all the required params here?
    # @param [Hash]
    # @param [Array<Symbol>]
    # @return [Boolean]
    #
    def validate_options(options, attrs)
      matched_attrs = options.keys & attrs
      if matched_attrs.to_set != attrs.to_set
        raise HelpScoutDocs::Error::OptionsError.new("#{(attrs - matched_attrs).join(", ")} required options are missing")
      end
    end
  end
end
