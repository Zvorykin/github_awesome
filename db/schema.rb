# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_05_195230) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "technology_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "technology_id"], name: "index_categories_on_name_and_technology_id", unique: true
    t.index ["name"], name: "index_categories_on_name"
    t.index ["technology_id"], name: "index_categories_on_technology_id"
  end

  create_table "repositories", force: :cascade do |t|
    t.string "name", null: false
    t.string "owner", null: false
    t.jsonb "info", default: "{}"
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_repositories_on_category_id"
    t.index ["name"], name: "index_repositories_on_name"
    t.index ["owner", "name"], name: "index_repositories_on_owner_and_name", unique: true
    t.index ["owner"], name: "index_repositories_on_owner"
  end

  create_table "technologies", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_technologies_on_name", unique: true
  end

end
