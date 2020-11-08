# frozen_string_literal: true

class CreateRepositories < ActiveRecord::Migration[6.0]
  def change
    create_table :repositories do |t|
      t.string :name, null: false, index: true
      t.string :owner, null: false, index: true
      t.jsonb :info, default: '{}'
      t.references :category, null: false

      t.timestamps
    end

    add_index :repositories, %i[owner name], unique: true
  end
end
