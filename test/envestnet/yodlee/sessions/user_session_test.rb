require 'test_helper'
require 'envestnet/yodlee/sessions/cobrand_session'
require 'envestnet/yodlee/sessions/user_session'

module Envestnet
  module Yodlee
    module Sessions
      class UserSessionTest < Minitest::Test
        def setup
          ::Envestnet::Yodlee.setup do |config|
            config.base_url = "https://developer.api.yodlee.com/ysl/restserver/v1"
            config.cobrand_login = ENV['YODLEE_COBRAND_LOGIN']
            config.cobrand_password = ENV['YODLEE_COBRAND_PASSWORD']
          end
        end

        def test_user_login_success
          cob_session = CobrandSession.new
          user_session = UserSession.new cobrand_session: cob_session
          login_name = ENV['YODLEE_USER_1_LOGIN_NAME']
          password = ENV['YODLEE_USER_1_PASSWORD']

          assert user_session.token.empty?

          VCR.use_cassette('cobrand_login_success', allow_playback_repeats: true) do
            cob_session.login login_name: ::Envestnet::Yodlee.cobrand_login, password: ::Envestnet::Yodlee.cobrand_password
          end

          VCR.use_cassette('user_login_success', allow_playback_repeats: true) do
            user_session.login login_name: login_name, password: password
          end

          refute user_session.token.empty?
        end
      end
    end
  end
end
