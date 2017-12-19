require 'json'

module Envestnet
  module Yodlee
    # {Envestnet::Yodlee::CobrandSession} is a lower-level object used to create a cobrand session.
    # Use {Envestnet::Yodlee::Authentication.new_session} which is a higher-level abstraction for
    # authenticating to Yodlee.
    # @since 0.1.0
    class CobrandSession
      attr_reader :token

      def initialize
        @token = ''
      end

      # Initiates a cobrand session
      #
      # @return the underlying response object for the HTTP client you've selected, RestClient by default
      def login
        HttpWrapper.post(
          url: "#{::Envestnet::Yodlee.base_url}/cobrand/login",
          body: {
            cobrand: {
              cobrandLogin: ::Envestnet::Yodlee.cobrand_login,
              cobrandPassword: ::Envestnet::Yodlee.cobrand_password,
              locale: 'en_US'
            }
          }.to_json,
          headers: { content_type: :json, accept: :json }
        ).tap { |response|
          @token = JSON.parse(response.body)['session']['cobSession']
        }
      end

      # Returns a string containing the cobrand session token which can be used as the value of the Authorization HTTP header
      def auth_header
        @token.empty? ? '' : "cobSession=#{@token}"
      end

      # Terminates the cobrand session
      #
      # @return the underlying response object for the HTTP client you've selected, RestClient by default
      def logout
        HttpWrapper.post(
          url: "#{::Envestnet::Yodlee.base_url}/cobrand/logout",
          headers: { accept: :json }
        )
      end
    end
  end
end
