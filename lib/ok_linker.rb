require 'pry'
require 'faraday'
require 'faraday_middleware'
require 'multi_json'

require_relative 'ok_linker/connection'
require_relative 'ok_linker/request'
require_relative 'ok_linker/version'
require_relative 'ok_linker/error'
require_relative 'ok_linker/config'
require_relative 'ok_linker/client'

module OkLinker
  class << self
    attr_accessor :config

    def new(options = {})
      OkLinker::Client.new(options)
    end

    def configure
      @config = OkLinker::Config.new
      yield @config
      @config
    end

    def options
      (@config && @config.options) || {}
    end
  end
end