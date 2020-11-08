# frozen_string_literal: true

class Repositories::FetchDataService < ApplicationService
  def initialize(repository_name:, owner:)
    @repository_name = repository_name
    @owner = owner
  end

  ENDPOINT = 'https://api.github.com/graphql'

  def call
    # usually we should not use error handling to validate params but for pet project it's ok
    raise 'Invalid repository name and/or owner' if @owner.blank? || @repository_name.blank?

    repository_data = response(@owner, @repository_name).data.repository.to_h
    @result = [nil, { repository_data: format_repository_data(repository_data) }]

    self
  rescue StandardError, Graphlient::Errors::FaradayServerError => e
    Rails.logger.debug "[#{self.class.name}] #{e}"
    @result = [:unprocessable_entity, { message: e.message }]
    self
  end

  private

  def client
    @client ||= Graphlient::Client.new(
      ENDPOINT,
      headers: {
        'Authorization' => "bearer #{ENV['GITHUB_TOKEN']}"
      },
      http_options: {
        read_timeout: 20,
        write_timeout: 30
      }
    )
  end

  def response(owner, name)
    @response ||= client.query <<~GRAPHQL
      query {
        repository(owner: "#{owner}", name: "#{name}") {
          stargazerCount
          forkCount
          pushedAt
          primaryLanguage { name }
          shortDescriptionHTML
        }
      }
    GRAPHQL
  end

  def format_repository_data(data)
    {
      short_description: data['shortDescriptionHTML'],
      stars_count: data['stargazerCount'],
      fork_count: data['forkCount'],
      pushed_at: data['pushedAt'], # should we convert it to timestamp?
      language: data.dig('primaryLanguage', 'name')
    }
  end
end
