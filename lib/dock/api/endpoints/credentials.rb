# frozen_string_literal: true

module Dock
  module Api
    class Credentials < Dock::Api::Base
      NAMESPACE = '/credentials'

      class << self
        def find(id)
          get("#{NAMESPACE}/#{id}")
        end

        def destroy(id)
          delete("#{NAMESPACE}/#{id}")
        end

        def create(attrs = {})
          post(NAMESPACE, attrs)
        end
      end
    end
  end
end
