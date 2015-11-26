RSpec.describe OkLinker do
  describe "configuration" do
    let(:access_token) {SecureRandom.hex}
    it "accepts an api key" do
      OkLinker.configure do |c|
        c.access_token = access_token
      end
      expect(OkLinker.options[:access_token]).to eq access_token
    end

    it "accepts an api key when creating client" do
      client = OkLinker::Client.new(access_token: access_token)
      expect(client.instance_variable_get('@access_token')).to eq access_token
    end
  end
end