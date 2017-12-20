require 'test_helper'
require 'envestnet/yodlee/sessions/cobrand_session'

module Envestnet
  module Yodlee
    module Sessions
      class CobrandSessionTest < Minitest::Test
        def setup
          ::Envestnet::Yodlee.setup do |config|
            config.base_url = "https://developer.api.yodlee.com/ysl/restserver/v1"
            config.cobrand_login = ENV['YODLEE_COBRAND_LOGIN']
            config.cobrand_password = ENV['YODLEE_COBRAND_PASSWORD']
          end
        end

        def test_cobrand_successful_login
          cob_session = CobrandSession.new

          assert cob_session.token.empty?

          VCR.use_cassette('cobrand_login_success', allow_playback_repeats: true) do
            cob_session.login login_name: ::Envestnet::Yodlee.cobrand_login, password: ::Envestnet::Yodlee.cobrand_password
          end

          refute cob_session.token.empty?
        end
      end
    end
  end
end
