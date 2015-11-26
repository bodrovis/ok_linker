RSpec.describe OkLinker do
  specify ".new" do
    client = OkLinker.new
    expect(client).to be_an_instance_of OkLinker::Client
  end

  describe "configuration" do
    let(:access_token) {SecureRandom.hex}
    it "accepts config options" do
      OkLinker.configure do |c|
        c.access_token = access_token
      end
      expect(OkLinker.options[:access_token]).to eq access_token
    end

    it "accepts config options when creating client" do
      client = OkLinker::Client.new(access_token: access_token)
      expect(client.instance_variable_get('@access_token')).to eq access_token
    end

    it "is possible to pass config block to OkLinker.config" do
      config = OkLinker::Config.configure do |c|
        c.access_token = access_token
      end
      OkLinker.config = config
      expect(OkLinker.config).to eq config
    end
  end
end