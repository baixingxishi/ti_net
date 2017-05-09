require 'spec_helper'

RSpec.describe TiNet::CallLog do
  let(:call_log) { TiNet::CallLog.new('unique_id') }
  let(:body) { { success: 'ok' } }

  it '#default_params' do
    seed = '147472d00ff66a050918a034a2853a07'
    allow(SecureRandom).to receive(:hex).and_return(seed)
    expect(call_log.send(:default_params)).to eq(
      enterpriseId: TiNet.config.enterprise_id,
      user_name: TiNet.config.username,
      seed: seed,
      pwd: Digest::MD5.hexdigest("#{Digest::MD5.hexdigest(TiNet.config.pwd)}#{seed}")
    )
  end

  it '#incoming_detail' do
    stub_request(:get, TiNet.config._incoming_detail_url).with(query: hash_including(uniqueId: 'unique_id')).to_return(body: body.to_json, status: 200)
    response = call_log.incoming_detail
    expect(response.body).to eq(body.merge(res_trans: nil).as_json)
  end

  it '#out_call_detail' do
    stub_request(:get, TiNet.config._out_call_detail_url).with(query: hash_including(uniqueId: 'unique_id')).to_return(body: body.to_json, status: 200)
    response = call_log.out_call_detail
    expect(response.body).to eq(body.merge(res_trans: nil).as_json)
  end

  context 'helpers' do
    it '.record_file_url' do
      seed = '147472d00ff66a050918a034a2853a07'
      allow(SecureRandom).to receive(:hex).and_return(seed)
      url = 'www.example.com'
      params = {
        enterpriseId: TiNet.config.enterprise_id,
        user_name: TiNet.config.username,
        seed: seed,
        pwd: Digest::MD5.hexdigest("#{Digest::MD5.hexdigest(TiNet.config.pwd)}#{seed}")
      }
      expect(TiNet::CallLog.record_file_url(url)).to eq("#{url}?#{params.to_query}")
    end
  end
end
