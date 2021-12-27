# frozen_string_literal: true

module Dock
  module Api
    class Verify < Dock::Api::Base
      NAMESPACE = '/verify'

      class << self
        def verify(attrs = {})
          post(NAMESPACE, attrs)
        end
      end
    end
  end
end
