module Envestnet
  module Yodlee
    module Accounts
      class << self
        include ::Envestnet::Yodlee::Utils

        def update_status(account_id:, status: '')
          url = "#{::Envestnet::Yodlee.base_url}/accounts/#{account_id}"
          url += "?status=#{status}" unless status.empty?
          HttpWrapper.post(url: url, headers: {
            authorization: "cobSession=#{cobrand_session},userSession=#{user_session_token}",
            accept: :json
          })
        end

        def get_details(account_id:, container: '')
          url = "#{::Envestnet::Yodlee.base_url}/accounts/#{account_id}"
          url += "?container=#{container}" unless container.empty?
          HttpWrapper.get(url: url, headers: {
            authorization: "cobSession=#{cobrand_session},userSession=#{user_session_token}",
            accept: :json
          })
        end

        def delete(account_id:)
          url = "#{::Envestnet::Yodlee.base_url}/accounts/#{account_id}"
          HttpWrapper.delete(url: url, headers: {
            authorization: "cobSession=#{cobrand_session},userSession=#{user_session_token}",
            accept: :json
          })
        end

        def get_historical_balances(
              account_id: '',
              include_cf: '',
              from_date: '',
              to_date: '',
              interval: '',
              account_recon_type: '',
              skip: '',
              top: ''
            )
          query_params = [
            :account_id,
            :include_cf,
            :from_date,
            :to_date,
            :interval,
            :account_recon_type,
            :skip,
            :top
          ].map { |param|
            uncapitalized_camelize(param.to_s)
          }.zip(
            [
              account_id,
              include_cf,
              from_date,
              to_date,
              interval,
              account_recon_type,
              skip,
              top
            ]
          ).reject { |query, value|
            value.to_s.strip.empty?
          }.to_h
        end
      end
    end
  end
end
