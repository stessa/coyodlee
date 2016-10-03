require "rest-client"

module Envestnet
  module Yodlee
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
      end
    end
  end
end
