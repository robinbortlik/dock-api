# frozen_string_literal: true

module Dock
  module Api
    class Base
      class << self
        def connection
          Dock::Api.connection
        end

        def get(url)
          connection.get(url).body
        end

        def delete(url)
          connection.delete(url).body
        end

        def post(url, data)
          connection.post(url, data).body
        end

        def patch(url, data)
          connection.patch(url, data).body
        end
      end
    end
  end
end
