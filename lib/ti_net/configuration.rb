module TiNet
  class Configuration
    attr_accessor :clink_host
    attr_accessor :username
    attr_accessor :enterprise_id
    attr_accessor :pwd
    attr_accessor :hotline

    attr_accessor :_incoming_detail_url
    attr_accessor :_out_call_detail_url
    attr_accessor :_clink_call_url
    attr_accessor :_agent_online_url
    attr_accessor :_agent_offline_url
    attr_accessor :_agent_status_url
    attr_accessor :_agent_hang_up_url
    attr_accessor :_agent_bind_tel_url

    attr_accessor :vlink_app_id
    attr_accessor :vlink_token
    attr_accessor :vlink_host
    attr_accessor :_vlink_call_url
  end
end
