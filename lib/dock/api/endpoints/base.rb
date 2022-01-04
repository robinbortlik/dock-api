# frozen_string_literal: true

module Dock
  module Api
    class NotFound < StandardError; end
    class BadRequest < StandardError; end
    class RequestError < StandardError; end
    class Unauthorized < StandardError; end
    class MethodNotAllowed < StandardError; end

    class Base
      class << self
        def connection
          Dock::Api.connection
        end

        def get(url)
          handle_status do
            connection.get(url)
          end
        end

        def delete(url)
          handle_status do
            connection.delete(url)
          end
        end

        def post(url, data)
          handle_status do
            connection.post(url, data)
          end
        end

        def patch(url, data)
          handle_status do
            connection.patch(url, data)
          end
        end

        private

        def handle_status
          response = yield
          case response.status
          when 400 then raise(Dock::Api::BadRequest, response.body)
          when 401 then raise(Dock::Api::Unauthorized, response.body)
          when 404 then raise(Dock::Api::NotFound, response.body)
          when 405 then raise(Dock::Api::MethodNotAllowed, response.body)
          when 500 then raise(Dock::Api::RequestError, response.body)
          else
            response.body
          end
        end
      end
    end
  end
end
