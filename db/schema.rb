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

ActiveRecord::Schema.define(version: 20170205150330) do

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
    t.integer  "geo_id"
    t.string   "division1"
    t.string   "division2"
    t.string   "division3"
    t.string   "division4"
    t.string   "division5"
    t.index ["city"], name: "index_businesses_on_city", using: :btree
    t.index ["company_name"], name: "index_businesses_on_company_name", using: :btree
    t.index ["contact_last_name"], name: "index_businesses_on_contact_last_name", using: :btree
    t.index ["country"], name: "index_businesses_on_country", using: :btree
    t.index ["division1"], name: "index_businesses_on_division1", using: :btree
    t.index ["division2"], name: "index_businesses_on_division2", using: :btree
    t.index ["division3"], name: "index_businesses_on_division3", using: :btree
    t.index ["division4"], name: "index_businesses_on_division4", using: :btree
    t.index ["division5"], name: "index_businesses_on_division5", using: :btree
    t.index ["email"], name: "index_businesses_on_email", using: :btree
    t.index ["geo_id"], name: "index_businesses_on_geo_id", using: :btree
    t.index ["industry_classification"], name: "index_businesses_on_industry_classification", using: :btree
    t.index ["naics_code"], name: "index_businesses_on_naics_code", using: :btree
    t.index ["number_of_employees"], name: "index_businesses_on_number_of_employees", using: :btree
    t.index ["phone"], name: "index_businesses_on_phone", using: :btree
    t.index ["sic_code"], name: "index_businesses_on_sic_code", using: :btree
    t.index ["state"], name: "index_businesses_on_state", using: :btree
    t.index ["status"], name: "index_businesses_on_status", using: :btree
  end

  create_table "campaign_industry_classifications", force: :cascade do |t|
    t.integer "campaign_id"
    t.integer "industry_classification_id"
  end

  create_table "campaigns", force: :cascade do |t|
    t.string   "title"
    t.integer  "revenue_id"
    t.integer  "ebitda_id"
    t.integer  "user_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "industry_id"
    t.string   "stage"
    t.decimal  "revenue_lower", precision: 8, scale: 2
    t.decimal  "revenue_upper", precision: 8, scale: 2
    t.decimal  "ebitda_lower",  precision: 8, scale: 2
    t.decimal  "ebitda_upper",  precision: 8, scale: 2
    t.index ["ebitda_id"], name: "index_campaigns_on_ebitda_id", using: :btree
    t.index ["industry_id"], name: "index_campaigns_on_industry_id", using: :btree
    t.index ["revenue_id"], name: "index_campaigns_on_revenue_id", using: :btree
    t.index ["stage"], name: "index_campaigns_on_stage", using: :btree
  end

  create_table "capital_industry_classifications", force: :cascade do |t|
    t.integer "capital_id"
    t.integer "industry_classification_id"
  end

  create_table "capitals", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.decimal  "revenue",    precision: 8, scale: 2
    t.decimal  "decimal",    precision: 8, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "company_types", force: :cascade do |t|
    t.string   "name"
    t.string   "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ebidta", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
    t.string   "location"
  end

  create_table "geos", force: :cascade do |t|
    t.string   "division1"
    t.string   "division2"
    t.string   "division3"
    t.string   "division4"
    t.string   "division5"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "state_abbreviation"
    t.index ["division1"], name: "index_geos_on_division1", using: :btree
    t.index ["division2"], name: "index_geos_on_division2", using: :btree
    t.index ["division3"], name: "index_geos_on_division3", using: :btree
    t.index ["division4"], name: "index_geos_on_division4", using: :btree
    t.index ["division5"], name: "index_geos_on_division5", using: :btree
  end

  create_table "industries", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_industries_on_code", using: :btree
  end

  create_table "industry_classifications", force: :cascade do |t|
    t.string "name"
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "recipient_id"
    t.integer  "thread_id"
    t.string   "subject"
    t.text     "body"
    t.boolean  "opened"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "opened_at"
    t.index ["recipient_id"], name: "index_messages_on_recipient_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "notes", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "body"
    t.string   "notable_type"
    t.integer  "notable_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["notable_type", "notable_id"], name: "index_notes_on_notable_type_and_notable_id", using: :btree
  end

  create_table "opportunities", force: :cascade do |t|
    t.string   "title"
    t.integer  "revenue_id"
    t.integer  "ebitda_id"
    t.integer  "user_id"
    t.integer  "industry_id"
    t.integer  "revenue_amount"
    t.integer  "ebidta_amount"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["industry_id"], name: "index_opportunities_on_industry_id", using: :btree
    t.index ["revenue_id"], name: "index_opportunities_on_revenue_id", using: :btree
    t.index ["user_id"], name: "index_opportunities_on_user_id", using: :btree
  end

  create_table "opportunity_industry_classifications", force: :cascade do |t|
    t.integer "opportunity_id"
    t.integer "industry_classification_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.index ["name"], name: "index_organizations_on_name", using: :btree
    t.index ["url"], name: "index_organizations_on_url", using: :btree
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

  create_table "searches", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "string"
    t.string   "query"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sic_codes", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.index ["code"], name: "index_sic_codes_on_code", using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context", using: :btree
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "user_businesses", force: :cascade do |t|
    t.integer "user_id"
    t.integer "business_id"
    t.index ["user_id", "business_id"], name: "index_user_businesses_on_user_id_and_business_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                          default: "",    null: false
    t.string   "encrypted_password",             default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                  default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "provider"
    t.string   "uid"
    t.integer  "avatar",                                         null: false
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "industry"
    t.string   "headline"
    t.string   "location"
    t.string   "picture_url"
    t.string   "profile_url"
    t.integer  "organization_id"
    t.boolean  "declined_to_state_organization", default: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  add_foreign_key "messages", "users"
  add_foreign_key "opportunities", "industries"
  add_foreign_key "opportunities", "revenues"
  add_foreign_key "opportunities", "users"
end
