# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140909013037) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "beds", force: true do |t|
    t.string   "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diagnoses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diagnoses_indicators", id: false, force: true do |t|
    t.integer "indicator_id"
    t.integer "diagnosis_id"
  end

  create_table "diagnoses_interventions", id: false, force: true do |t|
    t.integer "diagnosis_id"
    t.integer "intervention_id"
  end

  create_table "diagnoses_visits", id: false, force: true do |t|
    t.integer "diagnosis_id"
    t.integer "visit_id"
  end

  add_index "diagnoses_visits", ["diagnosis_id"], name: "index_diagnoses_visits_on_diagnosis_id", using: :btree
  add_index "diagnoses_visits", ["visit_id"], name: "index_diagnoses_visits_on_visit_id", using: :btree

  create_table "hospitalizations", force: true do |t|
    t.datetime "checkin"
    t.datetime "checkout"
    t.integer  "patient_id"
    t.integer  "bed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "origin"
    t.string   "transport_conditions"
    t.text     "obs"
    t.text     "reason"
  end

  create_table "indicator_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.boolean  "exclusive_options"
  end

  create_table "indicator_visits", force: true do |t|
    t.string   "obs"
    t.integer  "indicator_id"
    t.integer  "visit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "indicator_visits", ["indicator_id"], name: "index_indicator_visits_on_indicator_id", using: :btree
  add_index "indicator_visits", ["visit_id"], name: "index_indicator_visits_on_visit_id", using: :btree

  create_table "indicators", force: true do |t|
    t.string   "name"
    t.string   "obs_description"
    t.boolean  "has_obs"
    t.integer  "indicator_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interventions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interventions_visits", id: false, force: true do |t|
    t.integer "intervention_id"
    t.integer "visit_id"
  end

  add_index "interventions_visits", ["intervention_id"], name: "index_interventions_visits_on_intervention_id", using: :btree
  add_index "interventions_visits", ["visit_id"], name: "index_interventions_visits_on_visit_id", using: :btree

  create_table "patients", force: true do |t|
    t.string   "name"
    t.datetime "birthdate"
    t.string   "sex"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "childbirth_type"
    t.string   "apgar_first_min"
    t.string   "apgar_fifth_min"
    t.string   "gestational_age"
    t.string   "blood_type"
    t.string   "medical_record_number"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "cpf"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.boolean  "is_admin",               default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "visits", force: true do |t|
    t.datetime "datahora"
    t.integer  "hospitalization_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "head_circumference",    precision: 4, scale: 2
    t.decimal  "thoracic_perimeter",    precision: 4, scale: 2
    t.decimal  "waist_circumference",   precision: 2, scale: 0
    t.decimal  "weight",                precision: 4, scale: 2
    t.decimal  "stature",               precision: 4, scale: 2
    t.decimal  "incubator_temperature", precision: 2, scale: 0
    t.integer  "heart_rate"
    t.integer  "respiratory_rate"
    t.integer  "blood_pressure_min"
    t.integer  "blood_pressure_max"
    t.integer  "pulse"
    t.decimal  "temperature",           precision: 4, scale: 2
  end

end
