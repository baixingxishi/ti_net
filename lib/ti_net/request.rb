require_relative 'response'
require 'rest-client'

module TiNet
  class Request
    attr_reader :http_method, :url, :params

    class << self
      def get(url, params = {})
        new(:get, url, params).call
      end
    end

    def initialize(http_method, url, params = {})
      @http_method = http_method
      @url = url
      @params = params
    end

    def call
      Response.new(self, RestClient.send(http_method, url, params: params))
    end
  end
end
