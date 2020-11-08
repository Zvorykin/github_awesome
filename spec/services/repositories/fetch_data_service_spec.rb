# frozen_string_literal: true

require 'rails_helper'

describe Repositories::FetchDataService do
  let(:repository_name) { 'oauth2' }
  let(:owner) { 'oauth-xx' }

  describe '.call' do
    let(:params) { { repository_name: repository_name, owner: owner } }

    subject { described_class.new(params).call }

    let(:status) { subject.result.first }
    let(:payload) { subject.result.last }

    it 'should fetch repository data' do
      VCR.use_cassette('fetch_data') do
        expect(status).to be_nil
        expect(payload[:repository_data]).to eq(
          short_description: 'A Ruby wrapper for the OAuth 2.0 protocol.',
          stars_count: 1981,
          fork_count: 623,
          pushed_at: '2020-11-07T22:11:56Z',
          language: 'Ruby'
        )
      end
    end

    context 'wrong auth token' do
      it 'should fail' do
        VCR.use_cassette('unauthorized_fetch_data') do
          stub_const('ENV', ENV.to_hash.merge('GITHUB_TOKEN' => 'wrong_token'))
          expect(status).to eq :unprocessable_entity
          expect(payload[:message]).to eq 'the server responded with status 401'
        end
      end
    end

    context 'blank repository_name' do
      let(:repository_name) { nil }

      it 'should fail' do
        expect(status).to eq :unprocessable_entity
        expect(payload[:message]).to eq 'Invalid repository name and/or owner'
      end
    end

    context 'blank owner' do
      let(:owner) { nil }

      it 'should fail' do
        expect(status).to eq :unprocessable_entity
        expect(payload[:message]).to eq 'Invalid repository name and/or owner'
      end
    end
  end
end
