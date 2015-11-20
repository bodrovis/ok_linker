module OkLinker
  module Connection
    API_HOST = 'https://okey.link/api/v1'

    def connection(token = '')
      options = {
          :headers => {
              :accept => 'application/json',
              :user_agent => "ok_linker ruby gem/#{OkLinker::VERSION}",
              :'Access-Token' => token
          },
          :url => "#{API_HOST}/"
      }

      client = Faraday.default_adapter

      Faraday.new(options) do |conn|
        conn.request :multipart
        conn.request :url_encoded
        conn.adapter client
      end
    end
  end
end