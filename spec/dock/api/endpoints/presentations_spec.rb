# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Dock::Api::Presentations do
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

  let(:presentation_data) do
    {
      "holder": issuer_did,
      "credentials": [
        Dock::Api::Credentials.create(credentials)
      ]
    }
  end

  describe 'create' do
    it 'creates record', :vcr do
      data = described_class.create(presentation_data)

      expect(data).to match({
                              '@context' => be_a(Array),
                              'id' => be_a(String),
                              'type' => be_a(Array),
                              'proof' => be_a(Hash),
                              'verifiableCredential' => be_a(Array)
                            })
    end
  end
end
