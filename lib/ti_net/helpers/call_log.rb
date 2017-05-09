module TiNet
  module Helpers
    module CallLog
      def record_file_url(origin_url)
        seed = SecureRandom.hex
        params = {
          enterpriseId: TiNet.config.enterprise_id,
          userName: TiNet.config.username,
          seed: seed,
          pwd: Digest::MD5.hexdigest("#{Digest::MD5.hexdigest(TiNet.config.pwd)}#{seed}")
        }
        "#{origin_url}?#{params.to_query}"
      end
    end
  end
end
