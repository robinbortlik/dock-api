# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Dock::Api::Anchors do
  # setup anchor record
  before :all do
    VCR.use_cassette('Dock_Api_Anchors/create_anchor') do
      @anchor_data = [{ 'test' => Time.now }]

      @anchor_job = described_class.create(@anchor_data)

      WaitForJob.wait(@anchor_job['id'])
    end
  end

  describe 'create' do
    it 'creates new record', :vcr do
      expect(@anchor_job).to match({
                                     'data' => {
                                       'proofs' => be_a(Array),
                                       'root' => be_a(String)
                                     },
                                     'id' => be_a(String)
                                   })
    end
  end

  describe 'list' do
    it 'list records', :vcr do
      expect(described_class.list).to be_instance_of(Array)
    end
  end

  describe 'find' do
    it 'finds record', :vcr do
      did = described_class.list.first.fetch('root')
      data = described_class.find(did)

      expect(data).to match({
                              'created_at' => be_a(String),
                              'proofs' => be_a(Array),
                              'documentIds' => be_a(Array),
                              'root' => be_a(String),
                              'type' => be_a(String)
                            })
    end
  end

  describe 'verify' do
    it 'verify record', :vcr do
      record = described_class.list.first

      data = described_class.verify({
                                      proofs: record['proofs'],
                                      root: record['root'],
                                      documents: record['documentIds']
                                    })

      expect(data).to match({
                              'verified' => false,
                              'results' => be_a(Array)
                            })
    end
  end
end
