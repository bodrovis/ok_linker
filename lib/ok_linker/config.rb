module OkLinker
  class Config
    VALID_OPTIONS_KEYS = [:access_token].freeze

    attr_accessor(*VALID_OPTIONS_KEYS)

    def self.configure
      config = self.new
      yield config
      config
    end

    def initialize(options={})
      @access_token = options[:access_token] || options['access_token']
    end

    def options
      options = {}
      VALID_OPTIONS_KEYS.each{ |name| options[name] = send(name) }
      options
    end

  end
end