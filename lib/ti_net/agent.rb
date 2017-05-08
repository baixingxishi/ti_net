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
      TiNet::Request.get(online_url, default_params.merge(params))
    end

    def offline(unbind)
      TiNet::Request.get(offline_url, default_params.merge(cno: cno, unBind: unbind))
    end

    def status(type, description)
      params = {
        cno: cno,
        type: type,
        description: description
      }
      TiNet::Request.get(status_url, default_params.merge(params))
    end

    def hang_up
      TiNet::Request.get(hang_up_url, default_params.merge(cno: cno))
    end

    def bind_tel(tel)
      TiNet::Request.get(bind_tel_url, default_params.merge(cno: cno, bindTel: tel))
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

    def online_url
      "#{TiNet.config.clink_host}/interface/client/ClientOnline"
    end

    def offline_url
      "#{TiNet.config.clink_host}/interface/client/ClientOffline"
    end

    def status_url
      "#{TiNet.config.clink_host}/interface/client/ChangeStatus"
    end

    def hang_up_url
      "#{TiNet.config.clink_host}/interface/HangUp"
    end

    def bind_tel_url
      "#{TiNet.config.clink_host}/interface/client/ChangeBindTel"
    end
  end
end
