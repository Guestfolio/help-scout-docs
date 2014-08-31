require 'faraday_middleware'
require 'json/ext'

module HelpScoutDocs
  module Response
    class ParseJson < ::FaradayMiddleware::ParseJson
      def on_complete(env)
        status = env[:status]
        if status == 403 || status == 401
          error = env[:body].fetch(:error, "Unknown Help Scout Docs API error")
          raise Error::AuthenticationError.new(error)
        elsif status == 404
          raise Error::ResourceNotFoundError.new("Help Scout Docs Not found")
        elsif status =~ /^5/
          raise Error::ApiException.new("Help Scout Docs call unsuccessful. Try again later.")
        end
      end

      def call(env)
        @app.call(env).on_complete do |environment|
          environment[:body] = parse(environment[:body])
          on_complete(environment)
        end
      end

      private

      def parse(body)
        JSON.parse(body, symbolize_names: true)
      end
    end
  end
end
