require_relative 'request'

module TiNet
  class ClinkCall
    attr_reader :cno

    def initialize(cno)
      @cno = cno
    end

    def out(customer_number, options = {})
      params = build_params.merge(options).merge(customerNumber: customer_number, userField: CGI.unescape(options.to_query))
      TiNet::Request.get(TiNet.config._clink_call_url, params)
    end

    private

    def build_params
      {
        enterpriseId: TiNet.config.enterprise_id,
        hotline: TiNet.config.hotline,
        cno: cno,
        pwd: Digest::MD5.hexdigest(TiNet.config.pwd),
        sync: 0
      }
    end
  end
end
