# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Dock::Api::Profiles do
  let(:profile_data) do
    {
      "did": 'did:dock:5CDsD8HZa6TeSfgmMcxAkbSXYWeob4jFQmtU6sxr4XWTZzUA',
      "name": 'John Doe',
      "logo": 'https://pictures.com/logo.jpg'
    }
  end

  describe 'list' do
    it 'query list endpoint', :vcr do
      expect(described_class.list).to be_instance_of(Array)
    end
  end

  describe 'create' do
    it 'creates new record', :vcr do
      data = described_class.create(profile_data)

      expect(data).to match({
                              'did' => be_a(String),
                              'logo' => be_a(String),
                              'name' => be_a(String)
                            })
    end
  end

  describe 'find' do
    it 'finds record', :vcr do
      did = described_class.list.first.fetch('did')
      data = described_class.find(did)

      expect(data).to match({
                              'created' => be_a(String),
                              'did' => be_a(String),
                              'logo' => be_a(String),
                              'name' => be_a(String)
                            })
    end
  end

  describe 'update' do
    it 'update record', :vcr do
      record = described_class.list.first

      data = described_class.update(
        record.fetch('did'),
        profile_data
      )

      expect(data).to match({
                              'did' => be_a(String),
                              'logo' => be_a(String),
                              'name' => be_a(String)
                            })
    end
  end

  describe 'destroy' do
    it 'destroys record', :vcr do
      record = described_class.list.first
      data = described_class.destroy(record.fetch('did'))

      expect(data).to eq ''
    end
  end
end
