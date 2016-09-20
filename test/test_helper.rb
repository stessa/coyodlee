$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'envestnet/yodlee'

require 'minitest/autorun'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'test/cassettes'
  config.hook_into :webmock
  config.filter_sensitive_data('<COBRAND_LOGIN>') { ENV['YODLEE_COBRAND_LOGIN'] }
  config.filter_sensitive_data('<COBRAND_PASSWORD>') { ENV['YODLEE_COBRAND_PASSWORD'] }
end
