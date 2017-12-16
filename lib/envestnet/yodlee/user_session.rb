require 'json'

module Envestnet
  module Yodlee
    class UserSession
      attr_reader :token

      def initialize(cobrand_session:)
        @token = ''
        @cobrand_session = cobrand_session
      end

      def login(login_name:, password:)
        HttpWrapper.post(
          url: "#{::Envestnet::Yodlee.base_url}/user/login",
          body: {
            user: {
              loginName: login_name,
              password: password,
              locale: 'en_US'
            }
          }.to_json,
          headers: {
            content_type: :json,
            accept: :json,
            authorization: @cobrand_session.auth_header
          }
        ).tap { |response|
          @token = JSON.parse(response.body)['user']['session']['userSession']
        }
      end

      def logout
        HttpWrapper.post(
          url: "#{::Envestnet::Yodlee.base_url}/user/logout",
          headers: { accept: :json }
        )
      end
    end
  end
end
