require 'spec_helper'

RSpec.describe TiNet do
  it 'has a version number' do
    expect(TiNet::VERSION).not_to be nil
  end

  it '#config' do
    expect(TiNet.config.is_a?(TiNet::Configuration)).to eq(true)
  end

  it '#configure' do
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

    config = TiNet.config
    expect(config.enterprise_id).to eq('1')
    expect(config.hotline).to eq('2')
    expect(config.pwd).to eq('3')
    expect(config.clink_host).to eq('http://api.clink.cn')
    expect(config.username).to eq('username')

    expect(config.vlink_app_id).to eq('vlink_app_id')
    expect(config.vlink_token).to eq('vlink_token')
    expect(config.vlink_call_url).to eq('http://api.vlink.cn')
  end
end
