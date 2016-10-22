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

ActiveRecord::Schema.define(version: 20161022161818) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "businesses", force: :cascade do |t|
    t.string   "company_name"
    t.string   "contact_first_name"
    t.string   "contact_last_name"
    t.string   "contact_title"
    t.string   "phone"
    t.string   "email"
    t.string   "website"
    t.decimal  "revenue",                 precision: 8, scale: 2
    t.integer  "number_of_employees"
    t.string   "naics_code"
    t.string   "sic_code"
    t.string   "industry_classification"
    t.text     "description"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "postal_code"
    t.string   "status"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "parent_company"
    t.index ["city"], name: "index_businesses_on_city", using: :btree
    t.index ["company_name"], name: "index_businesses_on_company_name", using: :btree
    t.index ["contact_last_name"], name: "index_businesses_on_contact_last_name", using: :btree
    t.index ["country"], name: "index_businesses_on_country", using: :btree
    t.index ["email"], name: "index_businesses_on_email", using: :btree
    t.index ["industry_classification"], name: "index_businesses_on_industry_classification", using: :btree
    t.index ["naics_code"], name: "index_businesses_on_naics_code", using: :btree
    t.index ["number_of_employees"], name: "index_businesses_on_number_of_employees", using: :btree
    t.index ["phone"], name: "index_businesses_on_phone", using: :btree
    t.index ["sic_code"], name: "index_businesses_on_sic_code", using: :btree
    t.index ["state"], name: "index_businesses_on_state", using: :btree
    t.index ["status"], name: "index_businesses_on_status", using: :btree
  end

  create_table "campaigns", force: :cascade do |t|
    t.string   "title"
    t.integer  "revenue_id"
    t.integer  "ebitda_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "industry_id"
    t.index ["ebitda_id"], name: "index_campaigns_on_ebitda_id", using: :btree
    t.index ["industry_id"], name: "index_campaigns_on_industry_id", using: :btree
    t.index ["revenue_id"], name: "index_campaigns_on_revenue_id", using: :btree
  end

  create_table "ebidta", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "industries", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_industries_on_code", using: :btree
  end

  create_table "revenues", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.integer  "avatar",                              null: false
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

end
