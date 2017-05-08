require 'spec_helper'

RSpec.describe TiNet::Configuration do
  subject { TiNet::Configuration.new }

  context 'attr_accessors' do
    it { should respond_to(:clink_host) }
    it { should respond_to(:username) }
    it { should respond_to(:enterprise_id) }
    it { should respond_to(:pwd) }
    it { should respond_to(:hotline) }

    it { should respond_to(:vlink_app_id) }
    it { should respond_to(:vlink_token) }
    it { should respond_to(:vlink_call_url) }
  end
end
