# frozen_string_literal: true

# require "dock/api/version"
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'httpx'
require 'httpx/adapters/faraday'
require 'faraday'
require 'api/configuration'
require 'api/endpoints/base'
require 'api/endpoints/anchors'
require 'api/endpoints/credentials'
require 'api/endpoints/dids'
require 'api/endpoints/jobs'
require 'api/endpoints/presentations'
require 'api/endpoints/profiles'
require 'api/endpoints/registries'
require 'api/endpoints/revocation_status'
require 'api/endpoints/schemas'
require 'api/endpoints/verify'

module Dock
  module Api
    class Error < StandardError; end

    class << self
      def config
        @config ||= Configuration.new
      end

      def configure
        yield(config)
      end

      def connection
        @conn ||= Faraday.new(url: config.host) do |f|
          f.adapter :httpx
          f.request :json
          f.request :url_encoded
          f.request :retry, max: config.request_retry_count
          f.request :authorization, 'Bearer', config.auth_token
          f.response :json
          f.response :logger if config.log_requests
        end
      end
    end
  end
end
