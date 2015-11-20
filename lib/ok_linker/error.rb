module OkLinker
  class Error < StandardError
    ClientError = Class.new(self)
    ServerError = Class.new(self)

    # HTTP status code 400 - invalid params
    BadRequest = Class.new(ClientError)

    # HTTP status code 401 - not authorized
    Unauthorized = Class.new(ClientError)

    # HTTP status code 403 - invalid token
    Forbidden = Class.new(ClientError)

    # HTTP status code 501 - not implemented
    NotImplemented = Class.new(ServerError)

    ERRORS = {
        200 => OkLinker::Error::ClientError,
        400 => OkLinker::Error::BadRequest,
        401 => OkLinker::Error::Unauthorized,
        403 => OkLinker::Error::Forbidden,
        501 => OkLinker::Error::NotImplemented
    }

    class << self
      # Create a new error from an HTTP response
      def from_response(body)
        new(body.to_s)
      end
    end

    # Initializes a new Error object
    def initialize(message = '')
      super(message)
    end
  end
end