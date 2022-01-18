# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_01_18_093447) do

  create_table "heartbeats", force: :cascade do |t|
    t.string "status_code", null: false
    t.datetime "request_time", precision: 6, null: false
    t.integer "server_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status_message"
    t.datetime "response_time", precision: 6
    t.index ["server_id"], name: "index_heartbeats_on_server_id"
  end

  create_table "organisations", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "organisations_users", force: :cascade do |t|
    t.integer "organisation_id", null: false
    t.integer "user_id", null: false
    t.index ["organisation_id"], name: "index_organisations_users_on_organisation_id"
    t.index ["user_id"], name: "index_organisations_users_on_user_id"
  end

  create_table "servers", force: :cascade do |t|
    t.string "hostname", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "organisation_id", null: false
    t.index ["organisation_id"], name: "index_servers_on_organisation_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: 6
    t.datetime "remember_created_at", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
