require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
  add_filter "/bin/"
end

require 'dotenv'
require 'pry'
Dotenv.load

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
require 'ok_linker'

module SpecHelper
  def test_client(access_token = nil)
    return if @client && !access_token

    @client = OkLinker::Client.new(access_token: access_token || ENV.fetch("OKEY_LINK_KEY"))
  end
end

RSpec.configure do |config|
  config.include SpecHelper
end