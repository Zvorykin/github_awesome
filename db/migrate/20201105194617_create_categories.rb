# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false, index: true
      t.references :technology, null: false

      t.timestamps
    end

    add_index :categories, %i[name technology_id], unique: true
  end
end
