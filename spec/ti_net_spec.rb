require 'spec_helper'

RSpec.describe TiNet do
  it 'has a version number' do
    expect(TiNet::VERSION).not_to be nil
  end

  it '#config' do
    expect(TiNet.config.is_a?(TiNet::Configuration)).to eq(true)
  end

  it '#configure' do
    vlink_host = 'http://api.vlink.cn'
    clink_host = 'http://api.clink.cn'
    TiNet.configure do
      self.enterprise_id = '1'
      self.hotline = '2'
      self.pwd = '3'
      self.clink_host = clink_host
      self.username = 'username'

      self.vlink_app_id = 'vlink_app_id'
      self.vlink_token = 'vlink_token'
      self.vlink_host = vlink_host
      self._clink_call_url = 'http://api.vlink.cn/clink_call_url'
    end

    config = TiNet.config
    expect(config.enterprise_id).to eq('1')
    expect(config.hotline).to eq('2')
    expect(config.pwd).to eq('3')
    expect(config.clink_host).to eq('http://api.clink.cn')
    expect(config.username).to eq('username')

    expect(config.vlink_app_id).to eq('vlink_app_id')
    expect(config.vlink_token).to eq('vlink_token')
    expect(config.vlink_host).to eq('http://api.vlink.cn')

    expect(config._clink_call_url).to eq('http://api.vlink.cn/clink_call_url')
    expect(config._agent_online_url).to eq("#{clink_host}/interface/client/ClientOnline")
    expect(config._agent_offline_url).to eq("#{clink_host}/interface/client/ClientOffline")
    expect(config._agent_status_url).to eq("#{clink_host}/interface/client/ChangeStatus")
    expect(config._agent_hang_up_url).to eq("#{clink_host}/interface/HangUp")
    expect(config._agent_bind_tel_url).to eq("#{clink_host}/interface/client/ChangeBindTel")
    expect(config._incoming_detail_url).to eq("#{clink_host}/interfaceAction/cdrIbInterface!listCdrIb.action")
    expect(config._out_call_detail_url).to eq("#{clink_host}/interfaceAction/cdrObInterface!listCdrOb.action")
    expect(config._vlink_call_url).to eq("#{vlink_host}/interface/open/v1/webcall")
  end
end
