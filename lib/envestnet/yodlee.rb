require "envestnet/yodlee/version"
require "rest-client"

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
    end
  end
end
