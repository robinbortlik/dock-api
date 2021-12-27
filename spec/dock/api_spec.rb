# frozen_string_literal: true

RSpec.describe Dock::Api do
  it 'has a version number' do
    expect(Dock::Api::VERSION).not_to be nil
  end

  describe 'configure' do
    before do
      Dock::Api.configure do |conf|
        conf.auth_token = 'token'
        conf.host = 'https://test.host'
        conf.log_requests = true
        conf.request_retry_count = 5
      end
    end

    it 'configures auth_token' do
      expect(Dock::Api.config.auth_token).to eq('token')
    end

    it 'configures host' do
      expect(Dock::Api.config.host).to eq('https://test.host')
    end

    it 'configures log_requests' do
      expect(Dock::Api.config.log_requests).to eq(true)
    end

    it 'configures request retry count' do
      expect(Dock::Api.config.request_retry_count).to eq(5)
    end
  end
end
