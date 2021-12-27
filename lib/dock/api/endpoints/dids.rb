# frozen_string_literal: true

module Dock
  module Api
    class Dids < Dock::Api::Base
      NAMESPACE = '/dids'

      class << self
        def list
          get(NAMESPACE)
        end

        def find(id)
          get("#{NAMESPACE}/#{id}")
        end

        def destroy(id)
          delete("#{NAMESPACE}/#{id}")
        end

        def create(attrs = {})
          post(NAMESPACE, attrs)
        end

        def update(id, attrs = {})
          patch("#{NAMESPACE}/#{id}", attrs)
        end
      end
    end
  end
end
