# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Dock::Api::RevocationStatus do
  # setup registry record
  before :all do
    VCR.use_cassette('Dock_Api_RevocationStatus/create_registry') do
      did = Dock::Api::Dids.create.dig('data', 'did')
      registry_data = { "addOnly": false, "policy": [did] }

      @registry_job = Dock::Api::Registries.create(registry_data)

      WaitForJob.wait(@registry_job['id'])
    end
  end

  describe 'find' do
    it 'finds record', :vcr do
      credential = Factories::Credentials.create

      revocation = Dock::Api::Registries.revoke(
        @registry_job.dig('data', 'id'),
        credential_ids: [credential['id']]
      )

      data = described_class.find(
        reg_id: @registry_job.dig('data', 'id'),
        rev_id: revocation.dig('data', 'revokeIds').first
      )

      expect(data).to match({
                              'type' => false
                            })
    end
  end
end
