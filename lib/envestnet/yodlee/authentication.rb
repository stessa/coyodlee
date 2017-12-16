require 'envestnet/yodlee/cobrand_session'
require 'envestnet/yodlee/user_session'

module Envestnet
  module Yodlee
    class Authentication
      class << self
        def new_session
          cob_session = ::Envestnet::Yodlee::CobrandSession.new
          user_session = ::Envestnet::Yodlee::UserSession.new cobrand_session: cob_session
          new cobrand_session: cob_session, user_session: user_session
        end
      end

      attr_reader :cobrand_session, :user_session

      def initialize(cobrand_session:, user_session:)
        @cobrand_session = cobrand_session
        @user_session = user_session
      end

      def authenticate(login_name:, password:)
        @cobrand_session.login
        @user_session.login login_name: login_name, password: password
      end

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
