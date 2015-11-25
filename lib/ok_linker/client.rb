module OkLinker
  class Client
    def initialize(attrs = {})
      attrs = OkLinker.options.merge(attrs)
      Config::VALID_OPTIONS_KEYS.each do |key|
        instance_variable_set("@#{key}".to_sym, attrs[key])
      end
    end

    def shorten(url)
      post('make-short-url', url: url.to_s)
    end

    def hide(url)
      post('hide-url', url: url.to_s)
    end

    def clicks(url)
      get('get-url-clicks', url: url.to_s)
    end

    def urls(params = {})
      get('get-urls', params)
    end

    def get(method, params = {}, &block)
      request_method(:get, method, params, block)
    end

    def post(method, params = {}, &block)
      request_method(:post, method, params, block)
    end

    private

    def request_method(http_method, method, params, block)
      response = request.send(http_method, method, params)
      response = block.call response if block
      response
    end

    def request
      @request ||= Request.new(credentials)
    end

    def credentials
      {
          access_token:    @access_token
      }
    end
  end
end