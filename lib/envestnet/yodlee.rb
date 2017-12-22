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
    end
  end
end
