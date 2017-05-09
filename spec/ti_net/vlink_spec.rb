require 'spec_helper'

RSpec.describe TiNet::Vlink do
  let(:vlink) { TiNet::Vlink.new('17717392021') }

  it '#build_params' do
    time_now = Time.now
    allow(Time).to receive(:now).and_return(time_now)
    expect_result = {
      appId: TiNet.config.vlink_app_id,
      timestamp: time_now.to_i,
      sign: Digest::MD5.hexdigest("#{TiNet.config.vlink_app_id}#{TiNet.config.vlink_token}#{time_now.to_i}"),
      tel: '17717392021',
      transferNumber: '110',
      transferClid: '123',
      order_id: 1,
      userField: CGI.unescape({ order_id: 1 }.to_query)
    }
    expect(vlink.send(:build_params, '110', '123', order_id: 1)).to eq(expect_result)
  end

  it '#call' do
    params = { key: 'value' }
    allow(vlink).to receive(:build_params).and_return(params)
    stub_request(:get, "#{TiNet.config._vlink_call_url}?#{params.to_query}").to_return(body: { success: 'ok', res: '1' }.to_json, status: 200)
    response = vlink.call('110', '123')
    expect(response.body).to eq({ success: 'ok', res: '1', res_trans: '呼叫座席失败' }.as_json)
  end

  context 'helpers' do
    it '.record_file_url' do
      time_now = Time.now
      timestamp = time_now.to_i
      allow(Time).to receive(:now).and_return(time_now)
      url = 'www.example.com'
      params = {
        appId: TiNet.config.vlink_app_id,
        timestamp: timestamp,
        sign: Digest::MD5.hexdigest("#{TiNet.config.vlink_app_id}#{TiNet.config.vlink_token}#{timestamp}")
      }
      expect(TiNet::Vlink.record_file_url(url)).to eq("#{TiNet.config.vlink_host}/#{url}?#{params.to_query}")
    end
  end
end
