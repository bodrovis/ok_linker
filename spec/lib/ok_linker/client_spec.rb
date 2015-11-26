RSpec.describe OkLinker::Client do
  let(:full_url) { 'http://example.com' }

  specify "#shorten" do
    response = VCR.use_cassette("ShortenUrl") do
      test_client.shorten(full_url)
    end
    expect(response['data']['url']).to eq full_url
    expect(response['data']['short']).not_to be_empty
    expect(response['result']).to be true
  end

  specify "#get" do
    response = VCR.use_cassette("RawGet") do
      test_client.get('get-urls', epp: 1)
    end
    expect(response['result']).to be true
    expect(response['data']['pages']['epp']).to eq 1
  end

  specify "#post" do
    response = VCR.use_cassette("RawPost") do
      test_client.post('make-short-url', url: full_url)
    end
    expect(response['data']['url']).to eq full_url
    expect(response['data']['short']).not_to be_empty
    expect(response['result']).to be true
  end

  specify "#hide" do
    response = VCR.use_cassette("HideUrl") do
      test_client.hide(full_url)
    end
    expect(response['result']).to be true
  end

  specify "#clicks" do
    response = VCR.use_cassette("UrlClicks") do
      test_client.clicks(full_url)
    end
    expect(response['result']).to be true
    expect(response['data']['url']).to eq full_url
    expect(response['data']['clicks']).to eq 0
    expect(response['data']['cpd']).to eq 0
  end

  specify "#urls" do
    response = VCR.use_cassette("GetUrls") do
      test_client.urls(page: 1, epp: 2)
    end
    expect(response['result']).to be true
    expect(response['data']['pages']['current']).to eq 1
    expect(response['data']['pages']['epp']).to eq 2
  end

  context "errors" do
    it "should raise OkLinker::Error::Forbidden if access token is not valid" do
      VCR.use_cassette("ShortenUrlWithInvalidToken") do
        expect { test_client('1').shorten(full_url) }.to raise_error(OkLinker::Error::Forbidden)
      end
    end

    it "should raise OkLinker::Error::BadRequest if required attributes are not provided" do
      VCR.use_cassette("ShortenUrlWithMissingParams") do
        expect { test_client.shorten('') }.to raise_error(OkLinker::Error::BadRequest)
      end
    end

    it "should raise OkLinker::Error::Unauthorized if access_token is not provided" do
      VCR.use_cassette("ShortenUrlWithMissingToken") do
        expect { test_client('').shorten(full_url) }.to raise_error(OkLinker::Error::Unauthorized)
      end
    end

    it "should raise OkLinker::Error::NotImplemented if non-existent method is requested" do
      VCR.use_cassette("NonExistentMethod") do
        expect { test_client.get('some-test-method') }.to raise_error(OkLinker::Error::NotImplemented)
      end
    end
  end
end