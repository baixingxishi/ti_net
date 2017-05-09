module TiNet
  class Agent
    attr_reader :cno

    def initialize(cno)
      @cno = cno
    end

    def online(tel, status, options = {})
      params = {
        cno: cno,
        status: status,
        bindTel: tel,
        type: options.fetch(:type, 1)
      }
      TiNet::Request.get(TiNet.config._agent_online_url, default_params.merge(params))
    end

    def offline(unbind)
      TiNet::Request.get(TiNet.config._agent_offline_url, default_params.merge(cno: cno, unBind: unbind))
    end

    def status(type, description)
      params = {
        cno: cno,
        type: type,
        description: description
      }
      TiNet::Request.get(TiNet.config._agent_status_url, default_params.merge(params))
    end

    def hang_up
      TiNet::Request.get(TiNet.config._agent_hang_up_url, default_params.merge(cno: cno))
    end

    def bind_tel(tel)
      TiNet::Request.get(TiNet.config._agent_bind_tel_url, default_params.merge(cno: cno, bindTel: tel))
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
