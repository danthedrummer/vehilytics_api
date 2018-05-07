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

ActiveRecord::Schema.define(version: 20180507112425) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "devices", force: :cascade do |t|
    t.string "email", null: false
    t.string "device_name", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_devices_on_authentication_token", unique: true
    t.index ["device_name"], name: "index_devices_on_device_name", unique: true
    t.index ["email"], name: "index_devices_on_email", unique: true
    t.index ["reset_password_token"], name: "index_devices_on_reset_password_token", unique: true
    t.index ["user_id"], name: "index_devices_on_user_id"
  end

  create_table "devices_sensors", id: false, force: :cascade do |t|
    t.bigint "device_id", null: false
    t.bigint "sensor_id", null: false
  end

  create_table "readings", force: :cascade do |t|
    t.string "value", null: false
    t.bigint "sensor_id"
    t.bigint "report_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["report_id"], name: "index_readings_on_report_id"
    t.index ["sensor_id"], name: "index_readings_on_sensor_id"
  end

  create_table "reminders", force: :cascade do |t|
    t.string "title"
    t.integer "weekly_frequency"
    t.text "description"
  end

  create_table "reports", force: :cascade do |t|
    t.datetime "time_reported", null: false
    t.bigint "device_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_reports_on_device_id"
  end

  create_table "sensor_descriptions", force: :cascade do |t|
    t.text "info", null: false
    t.decimal "upper_range"
    t.decimal "lower_range"
    t.bigint "sensor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sensor_id"], name: "index_sensor_descriptions_on_sensor_id"
  end

  create_table "sensors", force: :cascade do |t|
    t.string "name", null: false
    t.string "shortname", null: false
    t.string "unit", null: false
    t.index ["name"], name: "index_sensors_on_name", unique: true
    t.index ["shortname"], name: "index_sensors_on_shortname", unique: true
  end

  create_table "sensors_users", id: false, force: :cascade do |t|
    t.bigint "sensor_id", null: false
    t.bigint "user_id", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "readings", "reports"
  add_foreign_key "readings", "sensors"
  add_foreign_key "reports", "devices"
  add_foreign_key "sensor_descriptions", "sensors"
end
