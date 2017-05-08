require 'spec_helper'

RSpec.describe TiNet::ClinkCall do
  before do
  end

  let(:params) do
    {
      enterpriseId: '1',
      hotline: '2',
      cno: 'cno',
      pwd: Digest::MD5.hexdigest('3'),
      sync: 0
    }
  end

  it '#build_params' do
    tinet = TiNet::ClinkCall.new('cno')
    expect(tinet.send(:build_params)).to eq(params)
  end

  it '#out' do
    stub_request(:get, "http://api.clink.cn/interface/PreviewOutcall?#{params.merge(customerNumber: '123', userField: '').to_query}").to_return(body: { success: 'ok', res: '1' }.to_json)
    response = TiNet::ClinkCall.new('cno').out('123')
    request = response.request
    expect(response.body).to eq({ success: 'ok', res: '1', res_trans: '呼叫座席失败' }.as_json)
    expect(request.url).to eq('http://api.clink.cn/interface/PreviewOutcall')
    expect(request.params).to eq(params.merge(customerNumber: '123', userField: ''))
  end
end
