# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Dock::Api::Credentials do
  let(:issuer_did) { Dock::Api::Dids.create.dig('data', 'did') }
  let(:subject_id) { 'did:dock:5CDsD8HZa6TeSfgmMcxAkbSXYWeob4jFQmtU6sxr4XWTZzUA' }
  let(:credentials) do
    {
      "persist": false,
      "anchor": true,
      "credential": {
        "id": subject_id,
        "context": ['https://www.w3.org/2018/credentials/examples/v1'],
        "type": ['UniversityDegreeCredential'],
        "subject": {
          "id": subject_id,
          "degree": {
            "type": 'BachelorDegree',
            "name": 'Bachelor of Science and Arts'
          }
        },
        "issuer": issuer_did,
        "issuanceDate": '2020-08-24T14:15:22Z'
      }
    }
  end

  describe 'create' do
    it 'creates new record', :vcr do
      data = described_class.create(credentials)

      expect(data).to match({
                              '@context' => be_a(Array),
                              'id' => be_a(String),
                              'issuanceDate' => be_a(String),
                              'issuer' => be_a(String),
                              'proof' => be_a(Hash),
                              'credentialSubject' => be_a(Hash),
                              'type' => be_a(Array)
                            })
    end
  end

  describe 'find' do
    it 'finds record', :vcr do
      did = described_class.create(credentials).fetch('id')
      data = described_class.find(did)

      expect(data).to match({
                              'id' => be_a(String),
                              'byteSize' => be_a(Integer),
                              'issuerKey' => be_a(String),
                              'createdAt' => be_a(String)
                            })
    end
  end

  describe 'destroy' do
    it 'destroys record', :vcr do
      did = described_class.create(credentials).fetch('id')
      data = described_class.destroy(did)

      expect(data).to eq('')
    end
  end
end
