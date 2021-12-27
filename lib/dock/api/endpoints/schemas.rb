# frozen_string_literal: true

module Dock
  module Api
    class Schemas < Dock::Api::Base
      NAMESPACE = '/schemas'

      class << self
        def list
          get(NAMESPACE)
        end

        def find(id)
          get("#{NAMESPACE}/#{id}")
        end

        def create(attrs = {})
          post(NAMESPACE, attrs)
        end
      end
    end
  end
end
