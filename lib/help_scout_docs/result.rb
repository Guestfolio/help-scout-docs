module HelpScoutDocs
  class Result
    attr_reader :response

    # Initialize a new Response, throw exception for fatal errors
    # @param [Hash] result
    #
    def initialize(response)
      @response = response
    end

    # Was it successful?
    # @return [Boolean]
    #
    def success?
      !error?
    end

    # Was there an error?
    # @return [Boolean]
    #
    def error?
      response.is_a?(Hash) ? response.has_key?(:status) : false
    end

    def message
      return unless error?
      response.fetch(:message)
    end
  end
end
