# frozen_string_literal: true

module Dock
  module Api
    class Jobs < Dock::Api::Base
      NAMESPACE = '/jobs'

      class << self
        def find(id)
          get("#{NAMESPACE}/#{id}")
        end
      end
    end
  end
end
