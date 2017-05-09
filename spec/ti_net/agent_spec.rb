require 'spec_helper'

RSpec.describe TiNet::Agent do
  let(:agent) {  TiNet::Agent.new('110') }
  let(:body) { { success: 'ok' } }

  it '#online' do
    stub_request(:get, TiNet.config._agent_online_url).with(query: hash_including(cno: '110', status: '1')).to_return(body: body.to_json, status: 200)
    response = agent.online('120', '1')
    expect(response.body).to eq(body.merge(res_trans: nil).as_json)
  end

  it '#offline' do
    stub_request(:get, TiNet.config._agent_offline_url).with(query: hash_including(cno: '110', unBind: '120')).to_return(body: body.to_json, status: 200)
    response = agent.offline('120')
    expect(response.body).to eq(body.merge(res_trans: nil).as_json)
  end

  it '#status' do
    stub_request(:get, TiNet.config._agent_status_url).with(query: hash_including(cno: '110', type: 'type', description: 'desc')).to_return(body: body.to_json, status: 200)
    response = agent.status('type', 'desc')
    expect(response.body).to eq(body.merge(res_trans: nil).as_json)
  end

  it '#hang_up' do
    stub_request(:get, TiNet.config._agent_hang_up_url).with(query: hash_including(cno: '110')).to_return(body: body.to_json, status: 200)
    response = agent.hang_up
    expect(response.body).to eq(body.merge(res_trans: nil).as_json)
  end

  it '#bind_tel' do
    stub_request(:get, TiNet.config._agent_bind_tel_url).with(query: hash_including(cno: '110', bindTel: '120')).to_return(body: body.to_json, status: 200)
    response = agent.bind_tel('120')
    expect(response.body).to eq(body.merge(res_trans: nil).as_json)
  end
end
