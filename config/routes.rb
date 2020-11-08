# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'spa#index'

  namespace 'api' do
    resources :technologies, only: %i[index]
    resources :repositories, only: %i[create]
  end
end
