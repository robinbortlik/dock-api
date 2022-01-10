# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Dock::Api::Registries do
  # setup registry record
  before :all do
    VCR.use_cassette('Dock_Api_Registries/create_registry') do
      did = Dock::Api::Dids.create.dig('data', 'did')
      registry_data = { "addOnly": false, "policy": [did] }

      @registry_job = described_class.create(registry_data)

      WaitForJob.wait(@registry_job['id'])
    end
  end

  describe 'list' do
    it 'query list endpoint', :vcr do
      expect(described_class.list).to be_instance_of(Array)
    end
  end

  describe 'create' do
    it 'creates new record', :vcr do
      expect(@registry_job).to match({
                                       'data' => {
                                         'id' => be_a(String),
                                         'policy' => {
                                           'type' => be_a(String),
                                           'policy' => be_a(Array),
                                           'addOnly' => false
                                         }
                                       },
                                       'id' => be_a(String)
                                     })
    end
  end

  describe 'find' do
    it 'finds record', :vcr do
      did = described_class.list.last.fetch('id')

      data = described_class.find(did)

      expect(data).to match({
                              'created_at' => be_a(String),
                              'id' => be_a(String),
                              'job_id' => be_a(String),
                              'policy_and_type' => {
                                'type' => be_a(String),
                                'policy' => be_a(Array),
                                'addOnly' => false
                              }
                            })
    end
  end

  describe 'revoke' do
    it 'revoke record', :vcr do
      credential = Factories::Credentials.create

      data = described_class.revoke(
        @registry_job.dig('data', 'id'),
        credential_ids: [credential['id']]
      )

      WaitForJob.wait(data['id'])

      expect(data).to match({
                              'id' => be_a(String),
                              'data' => {
                                'revokeIds' => be_a(Array)
                              }
                            })
    end
  end

  describe 'unrevoke' do
    it 'unrevoke record', :vcr do
      credential = Factories::Credentials.create

      data = described_class.unrevoke(
        @registry_job.dig('data', 'id'),
        credential_ids: [credential['id']]
      )

      WaitForJob.wait(data['id'])

      expect(data).to match({
                              'id' => be_a(String),
                              'data' => {
                                'revokeIds' => be_a(Array)
                              }
                            })
    end
  end

  describe 'destroy' do
    it 'destroys record', :vcr do
      data = described_class.destroy(@registry_job.dig('data', 'id'))

      WaitForJob.wait(data['id'])

      expect(data).to match({
                              'id' => be_a(String),
                              'data' => {
                                'status' => 'pending'
                              }
                            })
    end
  end
end
