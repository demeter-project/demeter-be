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

ActiveRecord::Schema.define(version: 2022_11_01_123007) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "native_plants", force: :cascade do |t|
    t.string "symbol"
    t.string "scientific_name"
    t.string "common_name"
    t.integer "frost_free_days_min"
    t.integer "temperature_min"
    t.string "edible"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
