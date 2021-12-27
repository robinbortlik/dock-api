# frozen_string_literal: true

module Dock
  module Api
    class Anchors < Dock::Api::Base
      NAMESPACE = '/anchors'

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

        def verify(attrs = {})
          post("#{NAMESPACE}/verify", attrs)
        end
      end
    end
  end
end
