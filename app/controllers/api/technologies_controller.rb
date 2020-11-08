# frozen_string_literal: true

class Api::TechnologiesController < ApiController
  def index
    technologies = Technology.eager_load(:categories, :repositories).order(:name)
    serialized_data = TechnologySerializer.render_as_json(technologies, params.to_unsafe_hash)

    render json: { objects: serialized_data }
  end
end
