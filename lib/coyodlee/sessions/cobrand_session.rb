require 'json'

module Coyodlee
  module Sessions
    class CobrandSession
      # Holds the cobrand session token
      #
      # @return [String] the cobrand session token
      attr_reader :token

      # Creates a new cobrand session
      def initialize(token='')
        @token = token
      end

      def get_events
        HttpWrapper.get(
          url: "#{::Coyodlee.base_url}/cobrand/config/notifications/events",
          headers: {
            authorization: auth_header,
            accept: :json
          }
        )
      end

      def subscribe_event(event_name, endpoint)
        HttpWrapper.post(
          url: "#{::Coyodlee.base_url}/cobrand/config/notifications/events/#{event_name}",
          body: {
            event: {
              callbackUrl: endpoint
            }
          }.to_json,
          headers: {
            authorization: auth_header,
            content_type: :json,
            accept: :json
          }
        )
      end

      def delete_event(event_name)
        HttpWrapper.delete(
          url: "#{::Coyodlee.base_url}/cobrand/config/notifications/events/#{event_name}",
          headers: {
            authorization: auth_header,
            content_type: :json,
            accept: :json
          }
        )
      end

      # Initiates a cobrand session
      #
      # @return the underlying response object for the HTTP client you've selected, RestClient by default
      def login(login_name:, password:)
        HttpWrapper.post(
          url: "#{::Coyodlee.base_url}/cobrand/login",
          body: {
            cobrand: {
              cobrandLogin: login_name,
              cobrandPassword: password,
              locale: 'en_US'
            }
          }.to_json,
          headers: { content_type: :json, accept: :json }
        ).tap { |response|
          @token = JSON.parse(response.body)['session']['cobSession']
        }
      end

      # Returns a string containing the cobrand session token which can be used as the value of the Authorization HTTP header
      def auth_header
        @token.empty? ? '' : "cobSession=#{@token}"
      end

      # Terminates the cobrand session
      #
      # @return the underlying response object for the HTTP client you've selected, RestClient by default
      def logout
        HttpWrapper.post(
          url: "#{::Coyodlee.base_url}/cobrand/logout"
        )
      end
    end
  end
end
