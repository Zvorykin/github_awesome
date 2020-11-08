# frozen_string_literal: true

class Technology < ApplicationRecord
  has_many :categories
  has_many :repositories, through: :categories, source: :technology
end
