# frozen_string_literal: true

require 'rails_helper'

describe Api::RepositoriesController, type: :controller do
  let(:default_params) do
    { repository: { technology: 'technology', category: 'category', repository: 'repository' } }
  end
  let(:params) { default_params }

  subject { post(:create, params: params) }

  it 'should create repository' do
    expect(CreateRepositoryJob).to receive(:perform_later)
      .with(technology: 'technology', category: 'category', repository: 'repository')
    subject
    expect(response).to have_http_status :ok
  end

  context 'missing repository params' do
    let(:params) { {} }

    it 'should fail' do
      expect(CreateRepositoryJob).to_not receive(:perform_later)
      expect { subject }.to raise_error ActionController::ParameterMissing
    end
  end
end
