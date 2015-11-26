require 'vcr'

VCR.configure do |c|
  c.ignore_hosts "codeclimate.com"
  c.allow_http_connections_when_no_cassette = true
  c.hook_into :webmock
  c.cassette_library_dir = File.join(File.dirname(__FILE__), "..", "fixtures", "vcr_cassettes")
  c.configure_rspec_metadata!
  c.filter_sensitive_data("<OKEY_LINK_KEY>") { ENV.fetch("OKEY_LINK_KEY") }

  c.before_record do |i|
    i.response.body.force_encoding("UTF-8")
  end
end