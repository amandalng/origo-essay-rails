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

ActiveRecord::Schema.define(version: 2020_09_06_155854) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "essays", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "student_name"
    t.string "email"
    t.string "applicant_type"
    t.string "country_applying"
    t.string "university_applying"
    t.string "program_applying"
    t.text "prompt"
    t.integer "word_count"
    t.string "attachment"
    t.text "notes"
    t.boolean "received", default: true
    t.boolean "assigned", default: false
    t.boolean "reviewed", default: false
    t.boolean "meeting_scheduled", default: false
    t.boolean "completed", default: false
    t.bigint "user_id"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "USD", null: false
    t.text "essay"
    t.boolean "agreement"
    t.boolean "invoice_sent"
    t.boolean "payment_received"
    t.string "discountcode"
    t.boolean "spam", default: false
    t.index ["user_id"], name: "index_essays_on_user_id"
  end

  create_table "leads", force: :cascade do |t|
    t.string "full_name"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "contacted", default: false
    t.boolean "converted", default: false
    t.text "notes"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_leads_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "amount_cents", default: 0, null: false
    t.string "checkout_session_id"
    t.bigint "essay_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state"
    t.string "student_name"
    t.string "email"
    t.string "applicant_type"
    t.string "country_applying"
    t.string "university_applying"
    t.string "program_applying"
    t.string "prompt"
    t.integer "word_count"
    t.text "notes"
    t.index ["essay_id"], name: "index_orders_on_essay_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "administrator", default: false
    t.string "full_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "essays", "users"
  add_foreign_key "leads", "users"
  add_foreign_key "orders", "essays"
end
