module TiNet
  class CallLog
    attr_reader :unique_id

    def initialize(unique_id)
      @unique_id = unique_id
    end

    def incoming_detail
      TiNet::Request.get(incoming_detail_url, default_params.merge(uniqueId: unique_id))
    end

    def out_call_detail
      TiNet::Request.get(out_call_detail_url, default_params.merge(uniqueId: unique_id))
    end

    private

    def default_params
      seed = SecureRandom.hex
      {
        enterpriseId: TiNet.config.enterprise_id,
        user_name: TiNet.config.username,
        seed: seed,
        pwd: Digest::MD5.hexdigest("#{Digest::MD5.hexdigest(TiNet.config.pwd)}#{seed}")
      }
    end

    def incoming_detail_url
      @incoming_detail_url ||= "#{TiNet.config.clink_host}/interfaceAction/cdrIbInterface!listCdrIb.action"
    end

    def out_call_detail_url
      @out_call_detail_url ||= "#{TiNet.config.clink_host}/interfaceAction/cdrObInterface!listCdrOb.action"
    end
  end
end
