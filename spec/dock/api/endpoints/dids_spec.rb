# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Dock::Api::Dids do
  # setup did record
  before :all do
    VCR.use_cassette('Dock_Api_Dids/create_did') do
      @did_job = described_class.create

      WaitForJob.wait(@did_job['id'])
    end
  end

  describe 'create' do
    it 'creates new record', :vcr do
      expect(@did_job).to match({
                                  'data' => {
                                    'controller' => be_a(String),
                                    'did' => be_a(String),
                                    'hexDid' => be_a(String)
                                  },
                                  'id' => be_a(String)
                                })
    end
  end

  describe 'list' do
    it 'query list endpoint', :vcr do
      expect(described_class.list).to be_instance_of(Array)
    end
  end

  describe 'find' do
    it 'finds record', :vcr do
      did = described_class.list.first.fetch('id')
      data = described_class.find(did)

      expect(data).to match({
                              '@context' => be_a(String),
                              'assertionMethod' => be_a(Array),
                              'authentication' => be_a(Array),
                              'id' => be_a(String),
                              'publicKey' => be_a(Array)
                            })
    end
  end

  describe 'update' do
    it 'update record', :vcr do
      record = described_class.list.first

      data = described_class.update(
        record.fetch('id'),
        keyType: 'ed25519'
      )

      WaitForJob.wait(data['id'])

      expect(data).to match({
                              'data' => {
                                'updated' => true
                              },
                              'id' => be_a(String)
                            })
    end
  end

  describe 'destroy' do
    it 'destroys record', :vcr do
      record = described_class.list.first

      data = described_class.destroy(record.fetch('id'))

      WaitForJob.wait(data['id'])

      expect(data).to match({
                              'data' => {
                                'status' => 'pending'
                              },
                              'id' => be_a(String)
                            })
    end
  end
end
