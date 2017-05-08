require 'ti_net/clink_call'
require 'ti_net/vlink'
require 'ti_net/agent'
require 'ti_net/call_log'
require 'ti_net/request'
require 'ti_net/response'
require 'ti_net/configuration'
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
    end
  end
end
