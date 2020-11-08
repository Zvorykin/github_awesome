# frozen_string_literal: true

class TechnologySerializer < Blueprinter::Base
  identifier :id

  fields :name

  association :categories, blueprint: CategorySerializer, name: :children,
                           if: ->(_field_name, _object, params) { params['tree_view'] == 'true' }
  association :categories, blueprint: CategorySerializer,
                           unless: ->(_field_name, _object, params) { params['tree_view'] == 'true' }

  field :node_id do |object|
    "technology-#{object.id}"
  end
end
