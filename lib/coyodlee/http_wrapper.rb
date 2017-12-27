require "rest-client"

module Coyodlee
  module HttpWrapper
    class << self
      def get(url:, params: {}, headers: {})
        if params.empty?
          RestClient.get(url, headers)
        else
          RestClient.get(url, { params: params }.merge(headers))
        end
      end

      def post(url:, body:, headers: {})
        RestClient.post(url, body, headers)
      end

      def put(url:, body:, headers: {})
        RestClient.put(url, body, headers)
      end

      def delete(url:, headers: {})
        RestClient.delete(url, nil, headers)
      end
    end
  end
end
