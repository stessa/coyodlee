require 'test_helper'
require 'envestnet/yodlee/user_session'

module Envestnet
  module Yodlee
    class UserSessionTest < Minitest::Test
      def setup
        ::Envestnet::Yodlee.setup do |config|
          config.base_url = "https://developer.api.yodlee.com/ysl/restserver/v1"
        end
      end

      def test_user_login_success
        user_session = UserSession.new
        login_name = ENV['YODLEE_USER_1_LOGIN_NAME']
        password = ENV['YODLEE_USER_1_PASSWORD']

        assert user_session.token.empty?

        VCR.use_cassette('user_login_success', allow_playback_repeats: true) do
          user_session.login login_name: login_name, password: password
        end

        refute user_session.token.empty?
      end
    end
  end
end
