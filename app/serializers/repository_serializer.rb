# frozen_string_literal: true

class RepositorySerializer < Blueprinter::Base
  identifier :id

  fields :owner, :name, :stars_count, :fork_count

  field :fork_count do |object|
    object.info.try(:[], 'fork_count')
  end

  field :stars_count do |object|
    object.info.try(:[], 'stars_count')
  end

  field :short_description do |object|
    object.info.try(:[], 'short_description')
  end

  field :pushed_at do |object|
    object.info.try(:[], 'pushed_at')
  end

  field :language do |object|
    object.info.try(:[], 'language')
  end

  field :reference do |object|
    "#{object.owner}/#{object.name}"
  end

  field :category_name do |object|
    object.category.name
  end

  field :node_id do |object|
    "repository-#{object.id}"
  end
end
