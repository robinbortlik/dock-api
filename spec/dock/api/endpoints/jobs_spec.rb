# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Dock::Api::Jobs do
  describe 'find' do
    let(:did) { Dock::Api::Dids.create.dig('data', 'did') }
    let(:registry_data) do
      {
        "addOnly": false,
        "policy": [
          did
        ]
      }
    end

    it 'finds record', :vcr do
      registry_job = Dock::Api::Registries.create(registry_data)

      data = described_class.find(registry_job['id'])

      expect(data).to match({
                              'id' => be_a(String),
                              'result' => be_a(Hash),
                              'status' => be_a(String)
                            })
    end
  end
end
