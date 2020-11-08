# frozen_string_literal: true

module Api
  class RepositoriesController < ApiController
    def create
      CreateRepositoryJob.perform_later(repository_params.to_h.symbolize_keys)

      head :ok
    end

    private

    def repository_params
      params.require(:repository).permit(:technology, :category, :repository)
    end
  end
end
