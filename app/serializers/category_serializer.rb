# frozen_string_literal: true

class CategorySerializer < Blueprinter::Base
  identifier :id

  fields :name, :repositories

  association :repositories, blueprint: RepositorySerializer, name: :children,
                             if: ->(_field_name, _object, params) { params['tree_view'] == 'true' }
  association :repositories, blueprint: RepositorySerializer,
                             unless: ->(_field_name, _object, params) { params['tree_view'] == 'true' }

  field :node_id do |object|
    "category-#{object.id}"
  end
end
