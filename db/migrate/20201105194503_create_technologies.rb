# frozen_string_literal: true

class CreateTechnologies < ActiveRecord::Migration[6.0]
  def change
    create_table :technologies do |t|
      t.string :name, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
