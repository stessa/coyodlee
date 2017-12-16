require 'test_helper'
require 'envestnet/yodlee/authentication'

module Envestnet
  module Yodlee
    class CredentialsTest < Minitest::Test
      def setup
        ::Envestnet::Yodlee.setup do |config|
          config.base_url = "https://developer.api.yodlee.com/ysl/restserver/v1"
          config.cobrand_login = ENV['YODLEE_COBRAND_LOGIN']
          config.cobrand_password = ENV['YODLEE_COBRAND_PASSWORD']
        end
      end

      def test_authentication
        auth = ::Envestnet::Yodlee::Authentication.new_session
        login_name = ENV['YODLEE_USER_1_LOGIN_NAME']
        password = ENV['YODLEE_USER_1_PASSWORD']

        VCR.use_cassette('authentication_success', allow_playback_repeats: true) do
          resp = auth.authenticate login_name: login_name, password: password
          assert_equal resp.code, 200
        end
      end
    end
  end
end
