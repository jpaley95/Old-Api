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

ActiveRecord::Schema.define(version: 20151002191100) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "communities", force: :cascade do |t|
    t.string   "name",                            null: false
    t.string   "headline"
    t.string   "video"
    t.string   "domains"
    t.text     "policy"
    t.text     "description"
    t.string   "website"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "linkedin"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.date     "founded_at"
    t.datetime "archived_at"
    t.integer  "category",                        null: false
    t.integer  "manage_profile",      default: 0, null: false
    t.integer  "manage_members",      default: 0, null: false
    t.integer  "manage_children",     default: 0, null: false
    t.integer  "manage_posts",        default: 0, null: false
    t.integer  "manage_listings",     default: 0, null: false
    t.integer  "manage_resources",    default: 0, null: false
    t.integer  "manage_events",       default: 0, null: false
    t.integer  "access_events",       default: 0, null: false
    t.integer  "access_resources",    default: 0, null: false
    t.integer  "access_statistics",   default: 0, null: false
    t.integer  "location_id"
    t.integer  "community_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "communities", ["category"], name: "index_communities_on_category", using: :btree
  add_index "communities", ["community_id"], name: "index_communities_on_community_id", using: :btree
  add_index "communities", ["location_id"], name: "index_communities_on_location_id", using: :btree

  create_table "community_members", force: :cascade do |t|
    t.integer  "user_id",      null: false
    t.integer  "community_id", null: false
    t.integer  "role_id",      null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "community_members", ["user_id", "community_id"], name: "index_community_members_on_user_id_and_community_id", unique: true, using: :btree

  create_table "degrees", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "degrees", ["name"], name: "index_degrees_on_name", unique: true, using: :btree

  create_table "educations", force: :cascade do |t|
    t.integer  "school_id",   null: false
    t.integer  "degree_id"
    t.date     "started_at"
    t.date     "finished_at"
    t.text     "grades"
    t.text     "activities"
    t.text     "classes"
    t.text     "honors"
    t.text     "description"
    t.integer  "user_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "educations", ["degree_id"], name: "index_educations_on_degree_id", using: :btree
  add_index "educations", ["school_id"], name: "index_educations_on_school_id", using: :btree
  add_index "educations", ["user_id"], name: "index_educations_on_user_id", using: :btree

  create_table "experiences", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "organization"
    t.integer  "team_id"
    t.date     "started_at"
    t.date     "finished_at"
    t.integer  "location_id"
    t.integer  "user_id",      null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "experiences", ["location_id"], name: "index_experiences_on_location_id", using: :btree
  add_index "experiences", ["team_id"], name: "index_experiences_on_team_id", using: :btree
  add_index "experiences", ["user_id"], name: "index_experiences_on_user_id", using: :btree

  create_table "fields", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "fields", ["name"], name: "index_fields_on_name", unique: true, using: :btree

  create_table "handles", force: :cascade do |t|
    t.string   "username",     null: false
    t.integer  "actable_id",   null: false
    t.string   "actable_type", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "handles", ["actable_id", "actable_type"], name: "index_handles_on_actable_id_and_actable_type", unique: true, using: :btree
  add_index "handles", ["username"], name: "index_handles_on_username", unique: true, using: :btree

  create_table "interests", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "tag_id",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "interests", ["user_id", "tag_id"], name: "index_interests_on_user_id_and_tag_id", unique: true, using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "description"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "locations", ["latitude", "longitude"], name: "index_locations_on_latitude_and_longitude", using: :btree

  create_table "majors", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "field_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "majors", ["user_id", "field_id"], name: "index_majors_on_user_id_and_field_id", unique: true, using: :btree

  create_table "minors", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "field_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "minors", ["user_id", "field_id"], name: "index_minors_on_user_id_and_field_id", unique: true, using: :btree

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
  end

  add_index "roles", ["name"], name: "index_roles_on_name", unique: true, using: :btree

  create_table "schools", force: :cascade do |t|
    t.string   "name",        null: false
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "schools", ["location_id"], name: "index_schools_on_location_id", using: :btree

  create_table "skills", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "tag_id",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "skills", ["user_id", "tag_id"], name: "index_skills_on_user_id_and_tag_id", unique: true, using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "user_followers", force: :cascade do |t|
    t.integer  "follower_id", null: false
    t.integer  "followed_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "user_followers", ["follower_id", "followed_id"], name: "index_user_followers_on_follower_id_and_followed_id", unique: true, using: :btree

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "role_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_roles", ["user_id", "role_id"], name: "index_user_roles_on_user_id_and_role_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birthday"
    t.integer  "gender"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "overview"
    t.text     "biography"
    t.text     "goals"
    t.text     "awards"
    t.string   "headline"
    t.string   "ask_about"
    t.integer  "looking_for"
    t.string   "website"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "linkedin"
    t.string   "github"
    t.integer  "privacy"
    t.boolean  "is_superuser",           default: false, null: false
    t.integer  "location_id"
    t.string   "email",                                  null: false
    t.string   "encrypted_password",                     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["location_id"], name: "index_users_on_location_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end
