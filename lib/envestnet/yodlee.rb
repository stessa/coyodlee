require "envestnet/yodlee/version"
require "rest-client"
require "json"

module Envestnet
  module Yodlee
    class << self
      attr_accessor :base_url, :cobranded_username, :cobranded_password

      def setup &block
        yield self
      end
      
      def cobrand_login(username: cobranded_username, password: cobranded_password)
        url = "#{base_url}/authenticate/coblogin"
        payload = { 'cobrandLogin' => username, 'cobrandPassword' => password }
        RestClient.post(url, payload)
      end

      def new_cobrand_login(username: cobranded_username, password: cobranded_password)
        url = "#{base_url}/cobrand/login"
        payload = {
          cobrand: {
            cobrandLogin: username,
            cobrandPassword: password,
            locale: 'en_US'
          }
        }
        RestClient.post(url, payload.to_json, { content_type: :json, accept: :json })
      end
    end
  end
end
