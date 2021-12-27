# frozen_string_literal: true

module Dock
  module Api
    class Registries < Dock::Api::Base
      NAMESPACE = '/registries'

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

        def revoke(id, credential_ids:)
          post("#{NAMESPACE}/#{id}", action: :revoke, credentialIds: credential_ids)
        end

        def unrevoke(id, credential_ids:)
          post("#{NAMESPACE}/#{id}", action: :unrevoke, credentialIds: credential_ids)
        end
      end
    end
  end
end
