require_relative "yodlee/version"
require_relative "yodlee/http_wrapper"
require "json"
require "yajl"

module Envestnet
  # The global Yodlee configuration object
  module Yodlee

    class << self
      # The base url Yodlee provides for your cobrand
      # @return [String] The base url Yodlee provides for your cobrand
      attr_accessor :base_url
      # The login of your cobrand
      # @return [String] The login of your cobrand
      attr_accessor :cobrand_login
      # The password of your cobrand
      # @return [String] The password of your cobrand
      attr_accessor :cobrand_password

      # The method to configure Yodlee parameters. Use this to set the global parameters such as {Yodlee.base_url}, {Yodlee.cobrand_login}, and {Yodlee.cobrand_password}
      # @yieldparam config [Yodlee] The Yodlee object
      def setup &block
        yield self
      end

      def user_details(cobrand_session_token:, user_session_token:)
        url = "#{base_url}/user"
        HttpWrapper.get(url: url, headers: {
          authorization: "cobSession=#{cobrand_session_token},userSession=#{user_session_token}",
          accept: :json
        })
      end

      def accounts(cobrand_session_token:, user_session_token:, status: '', container: '', provider_account_id: '')
        url = "#{base_url}/accounts"
        query_params = [:status, :container, :provider_account_id].zip([
          status,
          container,
          provider_account_id
        ]).reject { |query, value|
          value.to_s.strip.empty?
        }.to_h
        HttpWrapper.get(url: url, params: query_params, headers: {
          authorization: "cobSession=#{cobrand_session_token},userSession=#{user_session_token}",
          accept: :json
        })
      end

      def providers(cobrand_session_token:, user_session_token:)
        url = "#{base_url}/providers"
        HttpWrapper.get(url: url, headers: {
          authorization: "cobSession=#{cobrand_session_token},userSession=#{user_session_token}",
          accept: :json
        })
      end
    end
  end
end
