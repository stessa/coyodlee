require 'test_helper'

class Envestnet::YodleeTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Envestnet::Yodlee::VERSION
  end

  def test_it_provides_a_setup_hook
    ::Envestnet::Yodlee.setup do |config|
      config.base_url = 'http://example.org'
      config.cobranded_username = 'yodlee_cobranded_username'
      config.cobranded_password = 'yodlee_cobranded_password'
    end

    assert_equal 'http://example.org', ::Envestnet::Yodlee.base_url
    assert_equal 'yodlee_cobranded_username', ::Envestnet::Yodlee.cobranded_username
    assert_equal 'yodlee_cobranded_password', ::Envestnet::Yodlee.cobranded_password
  end

  def test_cobrand_login
    ::Envestnet::Yodlee.setup do |config|
      config.base_url = "https://rest.developer.yodlee.com/services/srest/restserver/v1.0"
    end

    VCR.use_cassette('cobrand_login', record: :new_episodes) do
      response = ::Envestnet::Yodlee.cobrand_login username: ENV['YODLEE_COBRAND_LOGIN'], password: ENV['YODLEE_COBRAND_PASSWORD']
      assert_equal 200, response.code
    end
  end
end
