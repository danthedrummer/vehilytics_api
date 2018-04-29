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

ActiveRecord::Schema.define(version: 20180429165054) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "devices", force: :cascade do |t|
    t.string "device_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_name"], name: "index_devices_on_device_name", unique: true
  end

  create_table "readings", force: :cascade do |t|
    t.decimal "value", null: false
    t.bigint "sensor_id"
    t.bigint "report_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["report_id"], name: "index_readings_on_report_id"
    t.index ["sensor_id"], name: "index_readings_on_sensor_id"
  end

  create_table "reports", force: :cascade do |t|
    t.datetime "time_reported", null: false
    t.bigint "device_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_reports_on_device_id"
  end

  create_table "sensors", force: :cascade do |t|
    t.string "name", null: false
    t.string "shortname", null: false
    t.string "unit", null: false
    t.index ["name"], name: "index_sensors_on_name", unique: true
    t.index ["shortname"], name: "index_sensors_on_shortname", unique: true
  end

  add_foreign_key "readings", "reports"
  add_foreign_key "readings", "sensors"
  add_foreign_key "reports", "devices"
end
