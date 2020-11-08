# frozen_string_literal: true

class CreateRepositoryJob < ApplicationJob
  queue_as :default

  def perform(args)
    Repositories::CreateService.new(args).call
  end
end
