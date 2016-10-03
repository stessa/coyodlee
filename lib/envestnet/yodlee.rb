require "envestnet/yodlee/version"
require "json"
require "yajl"
require "envestnet/yodlee/http_wrapper"

module Envestnet
  module Yodlee
    class << self
      attr_accessor :base_url, :cobranded_username, :cobranded_password

      def setup &block
        yield self
      end
      
      def cobrand_login(username: cobranded_username, password: cobranded_password)
        url = "#{base_url}/cobrand/login"
        payload = {
          cobrand: {
            cobrandLogin: username,
            cobrandPassword: password,
            locale: 'en_US'
          }
        }
        HttpWrapper.post(url: url, body: payload.to_json, headers: { content_type: :json, accept: :json })
      end

      def user_login(username:, password:, cobrand_session:, locale: 'en_US')
        url = "#{base_url}/user/login"
        payload = {
          user: {
            loginName: username,
            password: password,
            locale: locale
          }
        }
        HttpWrapper.post(url: url, body: payload.to_json, headers: {
          authorization: "cobSession=#{cobrand_session}",
          content_type: :json,
          accept: :json
        })
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
