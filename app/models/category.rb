# frozen_string_literal: true

class Category < ApplicationRecord
  belongs_to :technology
  has_many :repositories
end
