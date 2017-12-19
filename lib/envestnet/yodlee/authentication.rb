require 'envestnet/yodlee/cobrand_session'
require 'envestnet/yodlee/user_session'

module Envestnet
  module Yodlee
    # A higher-level abstraction for authenticating to Yodlee
    class Authentication
      class << self
        # Creates a session to authenticate to Yodlee
        # @return [Authentication] An authentication session
        def new_session
          cob_session = ::Envestnet::Yodlee::CobrandSession.new
          user_session = ::Envestnet::Yodlee::UserSession.new cobrand_session: cob_session
          new cobrand_session: cob_session, user_session: user_session
        end
      end

      # The cobrand session
      # @return [CobrandSession] The cobrand session
      attr_reader :cobrand_session

      # The user session
      # @return [UserSession] The user session
      attr_reader :user_session

      def initialize(cobrand_session:, user_session:)
        @cobrand_session = cobrand_session
        @user_session = user_session
      end

      # Authenticate to Yodlee
      # @param login_name [String] The login name of the user you're authenticating as
      # @param password [String] The password of the user you're authenticating as
      def authenticate(login_name:, password:)
        @cobrand_session.login
        @user_session.login login_name: login_name, password: password
      end

      # The authentication object as a string
      # @return The authentication object as a string which can be used as the value of the HTTP Authorization header
      def to_s
        unless @cobrand_session.token.empty? || @user_session.token.empty?
          "cobSession=#{@cobrand_session.token},userSession=#{@user_session.token}"
        else
          ""
        end
      end
    end
  end
end
