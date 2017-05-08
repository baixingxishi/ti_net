module TiNet
  class Response
    attr_reader :request, :response, :body

    def initialize(request, response)
      @request = request
      @response = response
      @body = parse_body
    end

    private

    def parse_body
      return ActiveSupport::HashWithIndifferentAccess.new(handle_response_body(JSON.parse(response.body))) if response
      ActiveSupport::HashWithIndifferentAccess.new({})
    end

    def handle_response_body(body)
      body['res_trans'] = res_mapping[body['res']]
      body
    end

    def res_mapping
      {
        '0' => '请求成功',
        '1' => '呼叫座席失败',
        '2' => '参数不正确',
        '3' => '用户验证没有通过',
        '4' => '账号被停用',
        '5' => '资费不足',
        '6' => '指定的业务尚未开通',
        '7' => '电话号码不正确',
        '8' => '座席工号（cno）不存在',
        '9' => '座席状态不为空闲，可能未登录或忙',
        '10' => '其他错误',
        '11' => '电话号码为黑名单',
        '12' => '座席不在线',
        '13' => '座席正在通话/呼叫中',
        '14' => '外显号码不正确',
        '33' => '同步调用的时候在没有接收到返回值时进行重复调用'
      }
    end
  end
end
