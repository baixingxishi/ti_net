require_relative 'helpers/call_log'

module TiNet
  class CallLog
    extend TiNet::Helpers::CallLog

    attr_reader :unique_id

    def initialize(unique_id)
      @unique_id = unique_id
    end

    def incoming_detail
      TiNet::Request.get(TiNet.config._incoming_detail_url, default_params.merge(uniqueId: unique_id))
    end

    def out_call_detail
      TiNet::Request.get(TiNet.config._out_call_detail_url, default_params.merge(uniqueId: unique_id))
    end

    private

    def default_params
      seed = SecureRandom.hex
      {
        enterpriseId: TiNet.config.enterprise_id,
        userName: TiNet.config.username,
        seed: seed,
        pwd: Digest::MD5.hexdigest("#{Digest::MD5.hexdigest(TiNet.config.pwd)}#{seed}")
      }
    end
  end
end
