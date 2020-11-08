# frozen_string_literal: true

require 'rails_helper'

describe Repositories::CreateService do
  let(:technology) { 'ruby' }
  let(:category) { 'authorization' }
  let(:repository_name) { 'oauth2' }
  let(:owner) { 'oauth-xx' }
  let(:reference) { "#{owner}/#{repository_name}" }

  describe '.call' do
    let(:params) do
      {
        technology: technology,
        category: category,
        repository: reference
      }
    end
    subject { described_class.new(params).call }

    let(:status) { subject.result.first }
    let(:payload) { subject.result.last }

    before(:each) do
      allow_any_instance_of(Repositories::FetchDataService).to \
        receive(:call).and_return(OpenStruct.new(result: [nil, { repository_data: { stars: 1 } }]))
    end

    it 'should create repository' do
      aggregate_failures do
        expect(status).to be_nil
        expect(Technology.count).to eq 1
        expect(Technology.first.name).to eq 'ruby'
        expect(Category.count).to eq 1
        expect(Category.first.name).to eq 'authorization'
        expect(Category.first.technology).to eq Technology.first
        expect(Repository.count).to eq 1
        expect(Repository.first).to have_attributes(
          owner: 'oauth-xx',
          name: 'oauth2',
          category: Category.first,
          info: { 'stars' => 1 }
        )
      end
    end

    context 'technology and category already exists' do
      let!(:existing_technology) { Technology.create!(name: technology) }
      let!(:existing_category) do
        Category.create!(name: category, technology: existing_technology)
      end

      it 'should create repository with existing category' do
        aggregate_failures do
          expect(status).to be_nil
          expect(Technology.count).to eq 1
          expect(Technology.first).to eq existing_technology
          expect(Category.count).to eq 1
          expect(Category.first).to eq existing_category
          expect(Repository.count).to eq 1
          expect(Repository.first.category).to eq existing_category
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
