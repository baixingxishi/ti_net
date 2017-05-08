require 'spec_helper'

RSpec.describe TiNet::Request do
  it '#get' do
    params = { key: 'value' }
    stub_request(:get, "http://api.clink.cn/?#{params.to_query}").to_return(body: { success: 'ok', res: '0' }.to_json, status: 200)
    response = TiNet::Request.get('http://api.clink.cn/', params)
    request = response.request
    expect(response.body).to eq({ success: 'ok', res: '0', res_trans: '请求成功' }.as_json)
    expect(request.url).to eq('http://api.clink.cn/')
    expect(request.params).to eq(params)
  end
end
