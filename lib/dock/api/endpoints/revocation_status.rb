# frozen_string_literal: true

module Dock
  module Api
    class RevocationStatus < Dock::Api::Base
      NAMESPACE = '/revocationStatus'

      class << self
        def find(reg_id:, rev_id:)
          get("#{NAMESPACE}/#{reg_id}/#{rev_id}")
        end
      end
    end
  end
end
