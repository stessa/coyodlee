require 'json'

module Envestnet
  module Yodlee
    class CobrandSession
      attr_reader :token

      def initialize
        @token = ''
      end

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

      def auth_header
        @token.empty? ? '' : "cobSession=#{@token}"
      end

      def logout
        HttpWrapper.post(
          url: "#{::Envestnet::Yodlee.base_url}/cobrand/logout",
          headers: { accept: :json }
        )
      end
    end
  end
end
