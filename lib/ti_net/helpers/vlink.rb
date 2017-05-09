module TiNet
  module Helpers
    module Vlink
      def record_file_url(origin_url)
        "#{TiNet.config.vlink_host}/#{origin_url}?#{default_params.to_query}"
      end
    end
  end
end
