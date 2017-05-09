module TiNet
  module Helpers
    module CallLog
      def record_file_url(origin_url)
        "#{origin_url}?#{default_params.to_query}"
      end
    end
  end
end
