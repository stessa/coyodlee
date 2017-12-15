require 'test_helper'

class Envestnet::YodleeTest < Minitest::Test

  def setup
    ::Envestnet::Yodlee.setup do |config|
      config.base_url = "https://developer.api.yodlee.com/ysl/restserver/v1"
      config.cobrand_login = ENV['YODLEE_COBRAND_LOGIN']
      config.cobrand_password = ENV['YODLEE_COBRAND_PASSWORD']
    end
  end

  def with_session_tokens &block
    cob_session = ::Envestnet::Yodlee::CobrandSession.new

    VCR.use_cassette('cobrand_login_success', allow_playback_repeats: true) do
      cob_session.login
    end

    login_name = ENV['YODLEE_USER_1_LOGIN_NAME']
    password = ENV['YODLEE_USER_1_PASSWORD']
    user_session = ::Envestnet::Yodlee::UserSession.new

    VCR.use_cassette('user_login_success', allow_playback_repeats: true) do
      user_session.login login_name: login_name, password: password
    end

    block.call(cob_session.token, user_session.token)
  end

  def test_that_it_has_a_version_number
    refute_nil ::Envestnet::Yodlee::VERSION
  end

  def test_it_provides_a_setup_hook
    ::Envestnet::Yodlee.setup do |config|
      config.base_url = 'http://example.org'
      config.cobrand_login = 'yodlee_cobranded_username'
      config.cobrand_password = 'yodlee_cobranded_password'
    end

    assert_equal 'http://example.org', ::Envestnet::Yodlee.base_url
    assert_equal 'yodlee_cobranded_username', ::Envestnet::Yodlee.cobrand_login
    assert_equal 'yodlee_cobranded_password', ::Envestnet::Yodlee.cobrand_password
  end

  def test_new_cobrand_login_without_arguments
    cob_session = ::Envestnet::Yodlee::CobrandSession.new

    VCR.use_cassette('cobrand_login_success') do
      response = cob_session.login

      assert_equal 200, response.code
    end
  end

  def test_new_cobrand_login_without_parameters_returns_session_token
    cob_session = ::Envestnet::Yodlee::CobrandSession.new

    VCR.use_cassette('cobrand_login_success') do
      cob_session.login

      refute_empty cob_session.token
    end
  end

  def test_user_login
    cob_session = ::Envestnet::Yodlee::CobrandSession.new

    VCR.use_cassette('cobrand_login_success', allow_playback_repeats: true, allow_unused_http_interactions: true) do
      cob_session.login
    end

    login_name = ENV['YODLEE_USER_1_LOGIN_NAME']
    password = ENV['YODLEE_USER_1_PASSWORD']
    user_session = ::Envestnet::Yodlee::UserSession.new

    VCR.use_cassette('user_login_success') do
      user_session.login login_name: login_name, password: password

      refute_empty user_session.token
    end
  end

  def test_user_details
    with_session_tokens do |cobrand_session, user_session|
      VCR.use_cassette('user_details_success') do
        response = ::Envestnet::Yodlee.user_details cobrand_session_token: cobrand_session, user_session_token: user_session
        user_json = JSON.parse(response.body, symbolize_names: true)

        refute_empty user_json[:user]
        refute_empty user_json[:user][:preferences]
        refute_empty user_json[:user][:email]
        refute_empty user_json[:user][:name]
        refute_empty user_json[:user][:loginName]
      end
    end
  end

  def test_providers
    with_session_tokens do |cobrand_session, user_session|
      VCR.use_cassette('providers_success') do
        response = ::Envestnet::Yodlee.providers cobrand_session_token: cobrand_session, user_session_token: user_session
        providers_json = JSON.parse(response.body, symbolize_names: true)

        refute_empty providers_json[:provider]
      end
    end
  end

  def test_accounts
    with_session_tokens do |cobrand_session, user_session|
      VCR.use_cassette('accounts_success') do
        response = ::Envestnet::Yodlee.accounts cobrand_session_token: cobrand_session, user_session_token: user_session
        accounts_json = JSON.parse(response.body, symbolize_names: true)

        refute_empty accounts_json[:account]
      end
    end
  end
end
