# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Dock::Api::Base do
  context 'status handling' do
    let(:response) { double(:response, status: status_code, body: 'body') }
    let(:connection) { double(:connection, get: response) }

    before do
      allow(described_class).to receive(:connection) { connection }
    end

    context 'when 200' do
      let(:status_code) { 200 }

      it 'returns response body' do
        expect(described_class.get('/')).to eq('body')
      end
    end

    context 'when 400' do
      let(:status_code) { 400 }

      it 'raises excepton' do
        expect do
          described_class.get('/')
        end.to raise_error(Dock::Api::BadRequest, 'body')
      end
    end

    context 'when 401' do
      let(:status_code) { 401 }

      it 'raises excepton' do
        expect do
          described_class.get('/')
        end.to raise_error(Dock::Api::Unauthorized, 'body')
      end
    end

    context 'when 404' do
      let(:status_code) { 404 }

      it 'raises excepton' do
        expect do
          described_class.get('/')
        end.to raise_error(Dock::Api::NotFound, 'body')
      end
    end

    context 'when 405' do
      let(:status_code) { 405 }

      it 'raises excepton' do
        expect do
          described_class.get('/')
        end.to raise_error(Dock::Api::MethodNotAllowed, 'body')
      end
    end

    context 'when 500' do
      let(:status_code) { 500 }

      it 'raises excepton' do
        expect do
          described_class.get('/')
        end.to raise_error(Dock::Api::RequestError, 'body')
      end
    end
  end
end
