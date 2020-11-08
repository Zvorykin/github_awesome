# frozen_string_literal: true

class Repositories::CreateService < ApplicationService
  def initialize(params = {})
    @params = params
    @owner, @repository_name = (@params[:repository] || '').split('/')
  end

  def call
    raise 'Invalid repository name and/or owner' if @owner.blank? || @repository_name.blank?

    if fetch_service.result.first
      @result = fetch_service.result
      return
    end

    repository_info = fetch_service.result.last[:repository_data]
    ActiveRecord::Base.transaction do
      repository = create_repository(repository_info)
      @result = [nil, { repository: repository }]
    end

    self
  rescue StandardError => e
    Rails.logger.error "[#{self.class.name}] #{e}"
    @result = [:unprocessable_entity, { message: e.message }]
    self
  end

  private

  def fetch_service
    @fetch_service ||= Repositories::FetchDataService
                       .new(owner: @owner, repository_name: @repository_name).call
  end

  def create_repository(repository_info)
    technology = Technology.create_or_find_by!(name: @params[:technology])
    category = Category.create_or_find_by!(name: @params[:category], technology: technology)
    repository = Repository.find_or_initialize_by(
      name: @repository_name,
      owner: @owner,
      category: category
    )
    repository.update!(info: repository_info) if repository.new_record?
    repository
  end
end
