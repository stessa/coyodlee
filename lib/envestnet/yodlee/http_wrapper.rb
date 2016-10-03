require "rest-client"

module Envestnet
  module Yodlee
    module HttpWrapper
      class << self
        def get(url:, headers: {})
          RestClient.get(url, headers)
        end

        def post(url:, body:, headers: {})
          RestClient.post(url, body, headers)
        end
      end
    end
  end
end
