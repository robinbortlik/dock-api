# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Dock::Api::Schemas do
  let(:issuer_did) { Dock::Api::Dids.create.dig('data', 'did') }
  let(:schema_data) do
    {
      "$schema": 'http://json-schema.org/draft-07/schema#',
      "description": 'Dock Schema Example',
      "type": 'object',
      "properties": {
        "id": {
          "type": 'string'
        },
        "emailAddress": {
          "type": 'string',
          "format": 'email'
        },
        "alumniOf": {
          "type": 'string'
        }
      },
      "required": %w[
        emailAddress
        alumniOf
      ],
      "additionalProperties": false,
      "author": issuer_did
    }
  end

  describe 'list' do
    it 'query list endpoint', :vcr do
      expect(described_class.list).to be_instance_of(Array)
    end
  end

  describe 'create' do
    it 'creates new record', :vcr do
      data = described_class.create(schema_data)

      expect(data).to match({
                              'data' => {
                                'id' => be_a(String),
                                'schema' => be_a(Hash),
                                'author' => be_a(String),
                                'signature' => be_a(Hash),
                                'uri' => be_a(String)
                              },
                              'id' => be_a(String)
                            })
    end
  end

  describe 'find' do
    it 'finds record', :vcr do
      did = described_class.list.first.fetch('id')

      data = described_class.find(did)

      expect(data).to match({
                              'id' => be_a(String),
                              'schema' => be_a(Hash),
                              'author' => be_a(String),
                              'uri' => be_a(String)
                            })
    end
  end
end
