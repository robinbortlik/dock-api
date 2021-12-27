# frozen_string_literal: true

module Dock
  module Api
    class Presentations < Dock::Api::Base
      NAMESPACE = '/presentations'

      class << self
        def create(**attrs)
          post(NAMESPACE.to_s, attrs)
        end
      end
    end
  end
end
