# frozen_string_literal: true

module Factories
  module Credentials
    SUBJECT_ID = 'did:dock:5CDsD8HZa6TeSfgmMcxAkbSXYWeob4jFQmtU6sxr4XWTZzUA'

    def self.create
      issuer_did = Dock::Api::Dids.create.dig('data', 'did')
      credential_data = {
        "persist": false,
        "anchor": true,
        "credential": {
          "id": SUBJECT_ID,
          "context": ['https://www.w3.org/2018/credentials/examples/v1'],
          "type": ['UniversityDegreeCredential'],
          "subject": {
            "id": SUBJECT_ID,
            "degree": {
              "type": 'BachelorDegree',
              "name": 'Bachelor of Science and Arts'
            }
          },
          "issuer": issuer_did,
          "issuanceDate": '2020-08-24T14:15:22Z'
        }
      }

      Dock::Api::Credentials.create(credential_data)
    end
  end
end
