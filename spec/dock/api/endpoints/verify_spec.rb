# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Dock::Api::Verify do
  describe 'verify' do
    it 'verify credentials', :vcr do
      credential = Factories::Credentials.create
      data = described_class.verify(credential)

      expect(data).to match({
                              'results' => be_a(Array),
                              'verified' => false
                            })
    end
  end
end
