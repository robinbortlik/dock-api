# frozen_string_literal: true

require 'bundler/setup'
require 'vcr'
require 'dock/api'
require 'pry'
require 'rspec/retry'

Dir["#{__dir__}/support/**/*.rb"].sort.each { |file| require file }

VCR_RECORD_MODE = ENV['VCR'] ? ENV['VCR'].to_sym : :once

VCR.config do |c|
  c.cassette_library_dir = 'spec/vcr'
  c.hook_into :faraday
  c.configure_rspec_metadata!

  c.default_cassette_options = { record_on_error: false, record: VCR_RECORD_MODE }

  c.ignore_request do |request|
    URI(request.uri).path.match(%r{/jobs/\d+}) # do not store request for job status
  end

  c.filter_sensitive_data('PLACEHOLDER_AUTHORIZATION') do |interaction|
    next unless interaction.request.headers['Authorization']

    interaction.request.headers['Authorization'][0]
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

Dock::Api.configure do |conf|
  conf.auth_token = ENV.fetch('DOCK_API_TOKEN')
  conf.host = 'https://api-testnet.dock.io'
  # conf.log_requests = true
  conf.request_retry_count = 1
end
