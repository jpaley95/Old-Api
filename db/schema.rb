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

ActiveRecord::Schema.define(version: 20151016171359) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name",        null: false
    t.text   "description"
  end

  create_table "communities", force: :cascade do |t|
    t.string   "name",                     null: false
    t.string   "headline"
    t.string   "video"
    t.string   "domains"
    t.text     "policy"
    t.text     "description"
    t.string   "website"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "linkedin"
    t.date     "founded_at"
    t.datetime "archived_at"
    t.integer  "category",                 null: false
    t.integer  "profile_permission_id",    null: false
    t.integer  "members_permission_id",    null: false
    t.integer  "children_permission_id",   null: false
    t.integer  "statistics_permission_id", null: false
    t.integer  "posts_permission_id",      null: false
    t.integer  "listings_permission_id",   null: false
    t.integer  "resources_permission_id",  null: false
    t.integer  "events_permission_id",     null: false
    t.integer  "events_privacy_id",        null: false
    t.integer  "resources_privacy_id",     null: false
    t.integer  "location_id"
    t.integer  "community_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
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

  create_table "community_teams", force: :cascade do |t|
    t.integer  "team_id",      null: false
    t.integer  "community_id", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "community_teams", ["team_id", "community_id"], name: "index_community_teams_on_team_id_and_community_id", unique: true, using: :btree

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

  create_table "files", force: :cascade do |t|
    t.string   "type",                 null: false
    t.string   "name"
    t.text     "description"
    t.string   "payload_file_name",    null: false
    t.string   "payload_content_type", null: false
    t.integer  "payload_file_size",    null: false
    t.datetime "payload_updated_at",   null: false
    t.integer  "user_id",              null: false
    t.integer  "owner_id",             null: false
    t.string   "owner_type",           null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "files", ["owner_type", "owner_id"], name: "index_files_on_owner_type_and_owner_id", using: :btree
  add_index "files", ["user_id"], name: "index_files_on_user_id", using: :btree

  create_table "handles", force: :cascade do |t|
    t.string   "username",     null: false
    t.integer  "actable_id",   null: false
    t.string   "actable_type", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "handles", ["actable_id", "actable_type"], name: "index_handles_on_actable_id_and_actable_type", unique: true, using: :btree
  add_index "handles", ["username"], name: "index_handles_on_username", unique: true, using: :btree

  create_table "industries", force: :cascade do |t|
    t.integer  "team_id",    null: false
    t.integer  "tag_id",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "industries", ["team_id", "tag_id"], name: "index_industries_on_team_id_and_tag_id", unique: true, using: :btree

  create_table "interests", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "tag_id",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "interests", ["user_id", "tag_id"], name: "index_interests_on_user_id_and_tag_id", unique: true, using: :btree

  create_table "kpis", force: :cascade do |t|
    t.string   "name",                         null: false
    t.text     "details"
    t.boolean  "is_completed", default: false, null: false
    t.datetime "started_at"
    t.datetime "finished_at"
    t.integer  "team_id",                      null: false
  end

  add_index "kpis", ["team_id"], name: "index_kpis_on_team_id", using: :btree

  create_table "listing_members", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "listing_id", null: false
    t.text     "review"
    t.integer  "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "listing_members", ["user_id", "listing_id"], name: "index_listing_members_on_user_id_and_listing_id", unique: true, using: :btree

  create_table "listing_skills", force: :cascade do |t|
    t.integer  "listing_id", null: false
    t.integer  "tag_id",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "listing_skills", ["listing_id", "tag_id"], name: "index_listing_skills_on_listing_id_and_tag_id", unique: true, using: :btree

  create_table "listings", force: :cascade do |t|
    t.integer  "handle_id",    null: false
    t.string   "title",        null: false
    t.text     "description"
    t.integer  "location_id"
    t.integer  "positions"
    t.integer  "category"
    t.integer  "hours"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "closed_at"
    t.integer  "salaryMin"
    t.integer  "salaryMax"
    t.integer  "salaryPeriod"
    t.integer  "equityMin"
    t.integer  "equityMax"
    t.integer  "privacy_id",   null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "listings", ["handle_id"], name: "index_listings_on_handle_id", using: :btree
  add_index "listings", ["location_id"], name: "index_listings_on_location_id", using: :btree
  add_index "listings", ["privacy_id"], name: "index_listings_on_privacy_id", using: :btree

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

  create_table "messages", force: :cascade do |t|
    t.integer  "handle_id",  null: false
    t.integer  "user_id",    null: false
    t.text     "content",    null: false
    t.integer  "thread_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "messages", ["handle_id"], name: "index_messages_on_handle_id", using: :btree
  add_index "messages", ["thread_id"], name: "index_messages_on_thread_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "metric_changes", force: :cascade do |t|
    t.text    "comment"
    t.integer "old_progress", null: false
    t.integer "new_progress", null: false
    t.integer "metric_id",    null: false
    t.integer "user_id",      null: false
  end

  add_index "metric_changes", ["metric_id"], name: "index_metric_changes_on_metric_id", using: :btree
  add_index "metric_changes", ["user_id"], name: "index_metric_changes_on_user_id", using: :btree

  create_table "minors", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "field_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "minors", ["user_id", "field_id"], name: "index_minors_on_user_id_and_field_id", unique: true, using: :btree

  create_table "permissions", force: :cascade do |t|
    t.string "name", null: false
  end

  add_index "permissions", ["name"], name: "index_permissions_on_name", unique: true, using: :btree

  create_table "posts", force: :cascade do |t|
    t.integer  "handle_id",  null: false
    t.integer  "user_id",    null: false
    t.text     "content",    null: false
    t.integer  "privacy_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["handle_id"], name: "index_posts_on_handle_id", using: :btree
  add_index "posts", ["privacy_id"], name: "index_posts_on_privacy_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "privacies", force: :cascade do |t|
    t.string "name", null: false
  end

  add_index "privacies", ["name"], name: "index_privacies_on_name", unique: true, using: :btree

  create_table "requests", force: :cascade do |t|
    t.string   "message"
    t.string   "email"
    t.datetime "accepted_at"
    t.datetime "denied_at"
    t.integer  "role"
    t.integer  "category",      null: false
    t.integer  "requestor_id",  null: false
    t.integer  "actor_id"
    t.integer  "initiator_id",  null: false
    t.integer  "terminator_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "requests", ["actor_id"], name: "index_requests_on_actor_id", using: :btree
  add_index "requests", ["initiator_id"], name: "index_requests_on_initiator_id", using: :btree
  add_index "requests", ["requestor_id"], name: "index_requests_on_requestor_id", using: :btree
  add_index "requests", ["terminator_id"], name: "index_requests_on_terminator_id", using: :btree

  create_table "resource_categories", force: :cascade do |t|
    t.integer  "resource_id", null: false
    t.integer  "category_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "resource_categories", ["resource_id", "category_id"], name: "index_resource_categories_on_resource_id_and_category_id", unique: true, using: :btree

  create_table "resource_tags", force: :cascade do |t|
    t.integer  "resource_id", null: false
    t.integer  "tag_id",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "resource_tags", ["resource_id", "tag_id"], name: "index_resource_tags_on_resource_id_and_tag_id", unique: true, using: :btree

  create_table "resources", force: :cascade do |t|
    t.string   "name",         null: false
    t.string   "contact"
    t.text     "overview"
    t.string   "website"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "linkedin"
    t.integer  "privacy_id",   null: false
    t.integer  "community_id", null: false
    t.integer  "location_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "resources", ["community_id"], name: "index_resources_on_community_id", using: :btree
  add_index "resources", ["location_id"], name: "index_resources_on_location_id", using: :btree

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

  create_table "success_metrics", force: :cascade do |t|
    t.text    "description"
    t.integer "progress",    default: 0, null: false
    t.integer "kpi_id",                  null: false
  end

  add_index "success_metrics", ["kpi_id"], name: "index_success_metrics_on_kpi_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "team_contact_privacies", force: :cascade do |t|
    t.integer  "team_id",    null: false
    t.integer  "privacy_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "team_contact_privacies", ["team_id", "privacy_id"], name: "index_team_contact_privacies_on_team_id_and_privacy_id", unique: true, using: :btree

  create_table "team_followers", force: :cascade do |t|
    t.integer  "team_id",    null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "team_followers", ["team_id", "user_id"], name: "index_team_followers_on_team_id_and_user_id", unique: true, using: :btree

  create_table "team_kpis_permissions", force: :cascade do |t|
    t.integer  "team_id",       null: false
    t.integer  "permission_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "team_kpis_permissions", ["team_id", "permission_id"], name: "index_team_kpis_permissions_on_team_id_and_permission_id", unique: true, using: :btree

  create_table "team_kpis_privacies", force: :cascade do |t|
    t.integer  "team_id",    null: false
    t.integer  "privacy_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "team_kpis_privacies", ["team_id", "privacy_id"], name: "index_team_kpis_privacies_on_team_id_and_privacy_id", unique: true, using: :btree

  create_table "team_listings_permissions", force: :cascade do |t|
    t.integer  "team_id",       null: false
    t.integer  "permission_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "team_listings_permissions", ["team_id", "permission_id"], name: "index_team_listings_permissions_on_team_id_and_permission_id", unique: true, using: :btree

  create_table "team_members", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "team_id",    null: false
    t.integer  "role_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "team_members", ["user_id", "team_id"], name: "index_team_members_on_user_id_and_team_id", unique: true, using: :btree

  create_table "team_posts_permissions", force: :cascade do |t|
    t.integer  "team_id",       null: false
    t.integer  "permission_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "team_posts_permissions", ["team_id", "permission_id"], name: "index_team_posts_permissions_on_team_id_and_permission_id", unique: true, using: :btree

  create_table "team_profile_permissions", force: :cascade do |t|
    t.integer  "team_id",       null: false
    t.integer  "permission_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "team_profile_permissions", ["team_id", "permission_id"], name: "index_team_profile_permissions_on_team_id_and_permission_id", unique: true, using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "tagline"
    t.string   "contact"
    t.text     "summary"
    t.string   "website"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "linkedin"
    t.string   "github"
    t.boolean  "commercial"
    t.boolean  "research"
    t.boolean  "social"
    t.date     "founded_at"
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "teams", ["location_id"], name: "index_teams_on_location_id", using: :btree

  create_table "thread_participants", force: :cascade do |t|
    t.integer  "handle_id",  null: false
    t.integer  "thread_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "thread_participants", ["handle_id", "thread_id"], name: "index_thread_participants_on_handle_id_and_thread_id", unique: true, using: :btree

  create_table "threads", force: :cascade do |t|
    t.string   "type",       null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "threads", ["type"], name: "index_threads_on_type", using: :btree
  add_index "threads", ["user_id"], name: "index_threads_on_user_id", using: :btree

  create_table "user_contact_privacies", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "privacy_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_contact_privacies", ["user_id", "privacy_id"], name: "index_user_contact_privacies_on_user_id_and_privacy_id", unique: true, using: :btree

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
