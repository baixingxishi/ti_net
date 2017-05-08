require 'spec_helper'

RSpec.describe TiNet::Response do
  let(:request) { TiNet::Request.new(:get, 'http://api.clink.cn/', key: 'value') }
  let(:rest_response) { double('Response', status: 200, body: { success: 'ok', res: '1' }.to_json) }
  let(:response) { TiNet::Response.new(request, rest_response) }

  it 'response' do
    expect(response.request).to eq(request)
    expect(response.response).to eq(rest_response)
    expect(response.body).to eq({ success: 'ok', res: '1', res_trans: '呼叫座席失败' }.as_json)
  end
end
