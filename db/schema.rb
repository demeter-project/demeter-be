# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_11_02_014528) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "gardens", force: :cascade do |t|
    t.string "name"
    t.string "zip_code"
    t.string "state_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plants", force: :cascade do |t|
    t.string "usda_symbol"
    t.string "scientific_name"
    t.string "common_name"
    t.string "states"
    t.string "flower_color"
    t.string "drought_tolerance"
    t.string "fire_tolerance"
    t.string "moisture_use"
    t.string "toxicity"
    t.string "duration"
    t.string "growth_rate"
    t.string "salinity_tolerance"
    t.string "shade_tolerance"
    t.string "edible"
    t.decimal "ph_minimum"
    t.decimal "ph_maximum"
    t.integer "temperature_min"
    t.integer "frost_free_days_min"
    t.integer "precipitation_min"
    t.integer "precipitation_max"
  end

  create_table "plots", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "garden_id"
    t.index ["garden_id"], name: "index_plots_on_garden_id"
  end

  add_foreign_key "plots", "gardens"
end
