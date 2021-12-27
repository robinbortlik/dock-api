# frozen_string_literal: true

module Dock
  module Api
    class Configuration
      attr_accessor :auth_token, :host, :log_requests, :request_retry_count

      def initialize
        @auth_token = nil
        @host = nil
        @log_requests = nil
        @request_retry_count = nil
      end

      def request_retry_count
        @request_retry_count || 1
      end
    end
  end
end
