# frozen_string_literal: true

require 'rails_helper'

describe Api::TechnologiesController, type: :controller do
  let!(:technology) { Technology.create!(name: 'ruby') }
  let!(:category) { Category.create!(name: 'authorization', technology: technology) }
  let!(:repository) do
    Repository.create!(name: 'oauth2', owner: 'oauth-xx', category: category)
  end
  let(:params) { {} }

  subject { get(:index, params: params) }
  let(:json_response) { JSON.parse(response.body).deep_symbolize_keys }

  describe '#index' do
    it 'should get technologies with associations' do
      subject
      aggregate_failures do
        expect(response).to have_http_status :ok
        expect(json_response[:objects].pluck(:name)).to eq ['ruby']
        expect(json_response.dig(:objects, 0, :categories).pluck(:name)).to eq ['authorization']
        expect(json_response.dig(:objects, 0, :categories, 0, :repositories).pluck(:reference)).to \
          eq ['oauth-xx/oauth2']
        expect(json_response.dig(:objects, 0, :categories, 0, :repositories, 0)).to include \
          :category_name, :id, :name, :owner, :node_id
      end
    end
  end
end
