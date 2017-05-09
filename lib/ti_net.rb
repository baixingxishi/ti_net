require 'ti_net/clink_call'
require 'ti_net/vlink'
require 'ti_net/agent'
require 'ti_net/call_log'
require 'ti_net/request'
require 'ti_net/response'
require 'ti_net/configuration'
require 'ti_net/version'
require 'rest-client'
require 'active_support'
require 'active_support/core_ext'

module TiNet
  class << self
    def config
      return @config if defined?(@config)
      @config = Configuration.new
      @config
    end

    def configure(&block)
      config.instance_exec(&block)
      config._clink_call_url = config._clink_call_url || "#{TiNet.config.clink_host}/interface/PreviewOutcall"

      config._agent_online_url = config._agent_online_url || "#{TiNet.config.clink_host}/interface/client/ClientOnline"
      config._agent_offline_url = config._agent_offline_url || "#{TiNet.config.clink_host}/interface/client/ClientOffline"
      config._agent_status_url = config._agent_status_url || "#{TiNet.config.clink_host}/interface/client/ChangeStatus"
      config._agent_hang_up_url = config._agent_hang_up_url || "#{TiNet.config.clink_host}/interface/HangUp"
      config._agent_bind_tel_url = config._agent_bind_tel_url || "#{TiNet.config.clink_host}/interface/client/ChangeBindTel"

      config._incoming_detail_url = config._incoming_detail_url || "#{TiNet.config.clink_host}/interfaceAction/cdrIbInterface!listCdrIb.action"
      config._out_call_detail_url = config._out_call_detail_url || "#{TiNet.config.clink_host}/interfaceAction/cdrObInterface!listCdrOb.action"

      config._vlink_call_url = config._vlink_call_url || "#{TiNet.config.vlink_host}/interface/open/v1/webcall"
    end
  end
end
