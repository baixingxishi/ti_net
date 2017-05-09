module TiNet
  module Helpers
    module Vlink
      def record_file_url(origin_url)
        timestamp = Time.now.to_i
        params = {
          appId: TiNet.config.vlink_app_id,
          timestamp: timestamp,
          sign: Digest::MD5.hexdigest("#{TiNet.config.vlink_app_id}#{TiNet.config.vlink_token}#{timestamp}")
        }
        "#{TiNet.config.vlink_host}/#{origin_url}?#{params.to_query}"
      end
    end
  end
end
