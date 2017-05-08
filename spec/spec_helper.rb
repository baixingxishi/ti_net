require 'bundler/setup'
require 'ti_net'
require 'webmock/rspec'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

TiNet.configure do
  self.enterprise_id = '1'
  self.hotline = '2'
  self.pwd = '3'
  self.clink_host = 'http://api.clink.cn'
  self.username = 'username'

  self.vlink_app_id = 'vlink_app_id'
  self.vlink_token = 'vlink_token'
  self.vlink_call_url = 'http://api.vlink.cn'
end
