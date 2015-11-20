module OkLinker
  class Request
    include OkLinker::Connection
    attr_reader :access_token

    def initialize(credentials)
      @access_token = credentials[:access_token]
    end

    def get(path, params = {})
      respond perform_request(:get, path, params)
    end

    def post(path, params = {})
      respond perform_request(:post, path, params)
    end

    private

    def perform_request(method, path, params)
      connection(access_token).send(method) do |req|
        req.url path
        if method == :get
          req.params = params
        else
          req.body = params
        end
      end
    end

    def respond(response)
      begin
        MultiJson.load(response.body)
      rescue MultiJson::ParseError
        return_error(response.status, response.body)
      end
    end

    def return_error(code, body)
      fail error(code, body)
    end

    def error(code, body)
      unless [200, 201].include?(code)
        klass = OkLinker::Error::ERRORS[code]
        klass.from_response(body)
      end
    end
  end
end