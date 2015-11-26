RSpec.describe OkLinker::Error do
  let(:message) {'error message'}
  it "creates a proper error from response" do
    error = OkLinker::Error.from_response(message)
    expect(error.message).to eq message
  end
end