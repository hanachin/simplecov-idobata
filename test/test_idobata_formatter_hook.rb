require 'minitest/autorun'
require 'simplecov/idobata'

describe SimpleCov::Formatter::IdobataFormatter do
  before do
    @original_simplecov_idobata_hook_url = ENV['SIMPLECOV_IDOBATA_HOOK_URL']
    @original_hook_url = SimpleCov::Formatter::IdobataFormatter.hook_url

    @badge = -> (result) {
      result.must_equal 'result'
      'hi'
    }
  end

  after do
    ENV['SIMPLECOV_IDOBATA_HOOK_URL'] = @original_simplecov_idobata_hook_url
    SimpleCov::Formatter::IdobataFormatter.hook_url = @original_hook_url
  end

  describe 'when hook_url is provided' do
    before do
      @hook_url = 'https://idobata.io/hook/generic/00000000-0000-0000-0000-000000000000'
      SimpleCov::Formatter::IdobataFormatter.hook_url = @hook_url
      @stub_https = stub_request(:post, @hook_url).with {|request|
        request.body == 'format=html&source=hi'
      }
    end

    it "should post badge to hook_url" do
      SimpleCov::Formatter::IdobataFormatter::Badge.stub :new, @badge do
        SimpleCov::Formatter::IdobataFormatter.new.format('result')
        assert_requested(@stub_https)
      end
    end

    describe 'when SIMPLECOV_IDOBATA_HOOK_URL is provided' do
      before do
        ENV['SIMPLECOV_IDOBATA_HOOK_URL'] = 'https://idobata.io/hook/generic/11111111-1111-1111-1111-111111111111'
      end

      it "should post badge to hook_url" do
        SimpleCov::Formatter::IdobataFormatter::Badge.stub :new, @badge do
          SimpleCov::Formatter::IdobataFormatter.new.format('result')
          assert_requested(@stub_https)
        end
      end
    end
  end

  describe 'when SIMPLECOV_IDOBATA_HOOK_URL is provided' do
    before do
      @simplecov_idobata_hook_url = 'https://idobata.io/hook/generic/11111111-1111-1111-1111-111111111111'
      ENV['SIMPLECOV_IDOBATA_HOOK_URL'] = @simplecov_idobata_hook_url
      @stub_https = stub_request(:post, @simplecov_idobata_hook_url).with {|request|
        request.body == 'format=html&source=hi'
      }
    end

    it "should post badge to SIMPLECOV_IDOBATA_HOOK_URL environment variable" do
      SimpleCov::Formatter::IdobataFormatter::Badge.stub :new, @badge do
        SimpleCov::Formatter::IdobataFormatter.new.format('result')
        assert_requested(@stub_https)
      end
    end
  end

  describe 'when both SIMPLECOV_IDOBATA_HOOK_URL and hook_url not provided' do
    before do
      WebMock.allow_net_connect!
    end

    after do
      WebMock.disable_net_connect!(allow: /codeclimate.com/)
    end

    it "should raise error" do
      SimpleCov::Formatter::IdobataFormatter::Badge.stub :new, @badge do
        proc {
          SimpleCov::Formatter::IdobataFormatter.new.format('result')
        }.must_raise URI::InvalidURIError
      end
    end
  end
end
