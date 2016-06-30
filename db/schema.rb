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

ActiveRecord::Schema.define(version: 20160630132426) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "contact_messages", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "message"
    t.integer  "action"
    t.string   "mail"
    t.string   "city"
    t.string   "full_name"
    t.integer  "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "contact_messages", ["user_id"], name: "index_contact_messages_on_user_id", using: :btree

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "startup_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "favorites", ["startup_id"], name: "index_favorites_on_startup_id", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "founders", force: :cascade do |t|
    t.integer  "startup_id"
    t.string   "name"
    t.string   "surname"
    t.string   "position"
    t.text     "description"
    t.text     "quote"
    t.string   "linkedin_url"
    t.string   "photo_url"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
  end

  add_index "founders", ["startup_id"], name: "index_founders_on_startup_id", using: :btree

  create_table "partners", force: :cascade do |t|
    t.string   "name"
    t.string   "logo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "partners_startups", id: false, force: :cascade do |t|
    t.integer "partner_id"
    t.integer "startup_id"
  end

  add_index "partners_startups", ["partner_id"], name: "index_partners_startups_on_partner_id", using: :btree
  add_index "partners_startups", ["startup_id"], name: "index_partners_startups_on_startup_id", using: :btree

  create_table "references", force: :cascade do |t|
    t.integer  "startup_id"
    t.string   "url"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
  end

  add_index "references", ["startup_id"], name: "index_references_on_startup_id", using: :btree

  create_table "startups", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.string   "name"
    t.string   "logo_url"
    t.text     "description"
    t.text     "pitch"
    t.string   "twitter_url"
    t.string   "facebook_url"
    t.string   "google_url"
    t.string   "linkedin_url"
    t.string   "youtube_url"
    t.string   "instagram_url"
    t.string   "crowdfunding_url"
    t.boolean  "is_active",        default: false, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "startups", ["category_id"], name: "index_startups_on_category_id", using: :btree
  add_index "startups", ["user_id"], name: "index_startups_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "surname"
    t.string   "school"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.integer  "role",                   default: 1,       null: false
    t.boolean  "is_premium",             default: false,   null: false
    t.text     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

end
