require_relative 'helpers/vlink'

module TiNet
  class Vlink
    extend TiNet::Helpers::Vlink

    attr_reader :caller

    def initialize(caller)
      @caller = caller
    end

    def call(answerer, transfer_clid, options = {})
      TiNet::Request.get(TiNet.config._vlink_call_url, build_params(answerer, transfer_clid, options))
    end

    private

    def build_params(answerer, transfer_clid, options = {})
      default_params.merge(tel: caller,
                           transferNumber: answerer,
                           transferClid: transfer_clid).merge(options).merge(userField: CGI.unescape(options.to_query))
    end

    def default_params
      timestamp = Time.now.to_i
      {
        appId: TiNet.config.vlink_app_id,
        timestamp: timestamp,
        sign: Digest::MD5.hexdigest("#{TiNet.config.vlink_app_id}#{TiNet.config.vlink_token}#{timestamp}")
      }
    end
  end
end
