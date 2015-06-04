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

ActiveRecord::Schema.define(version: 20150603172213) do

  create_table "comments", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "idea_id"
    t.integer  "user_id",                null: false
    t.integer  "parent_id"
    t.integer  "lft",                    null: false
    t.integer  "rgt",                    null: false
    t.integer  "depth",      default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "comments", ["idea_id"], name: "index_comments_on_idea_id", using: :btree
  add_index "comments", ["parent_id"], name: "index_comments_on_parent_id", using: :btree
  add_index "comments", ["rgt"], name: "index_comments_on_rgt", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

#ActiveRecord::Schema.define(version: 20150526194833) do

  create_table "competencies", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "competencies", ["name"], name: "index_competencies_on_name", using: :btree

  create_table "competency_users", force: true do |t|
    t.integer  "competency_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "event_groups", force: true do |t|
    t.integer  "event_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "event_groups", ["event_id", "group_id"], name: "index_event_groups_on_event_id_and_group_id", using: :btree
  add_index "event_groups", ["event_id"], name: "index_event_groups_on_event_id", using: :btree
  add_index "event_groups", ["group_id"], name: "event_groups_group_id_fk", using: :btree

  create_table "events", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "description"
    t.date     "start_date"
    t.date     "stop_date"
    t.time     "start_time"
    t.time     "stop_time"
    t.string   "location"
    t.string   "event_url"
    t.string   "map_url"
    t.integer  "number_going"
    t.integer  "number_invited"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "image"
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "groups", ["name"], name: "index_groups_on_name", unique: true, using: :btree

  create_table "idea_competencies", force: true do |t|
    t.integer  "idea_id"
    t.integer  "competency_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "idea_roles", force: true do |t|
    t.integer  "idea_id"
    t.integer  "user_id"
    t.boolean  "founder",    default: false
    t.boolean  "admin",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "idea_roles", ["created_at"], name: "index_idea_roles_on_created_at", using: :btree

  create_table "idea_statuses", force: true do |t|
    t.string   "key"
    t.string   "name"
    t.text     "description"
    t.text     "icon"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "idea_statuses", ["key"], name: "index_idea_statuses_on_key", using: :btree

  create_table "idea_votes", force: true do |t|
    t.integer  "idea_id"
    t.integer  "user_id"
    t.boolean  "participate", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "idea_votes", ["created_at"], name: "index_idea_votes_on_created_at", using: :btree

  create_table "ideas", force: true do |t|
    t.integer  "idea_status_id"
    t.string   "name"
    t.text     "pitch"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "ideas", ["created_at"], name: "index_ideas_on_created_at", using: :btree

  create_table "invites", force: true do |t|
    t.integer  "event_id"
    t.string   "email"
    t.boolean  "status",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "invites", ["event_id", "email"], name: "index_invites_on_event_id_and_email", using: :btree
  add_index "invites", ["event_id"], name: "index_invites_on_event_id", using: :btree

  create_table "oauth2_identities", force: true do |t|
    t.string   "provider",         null: false
    t.string   "provider_user_id", null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "oauth2_identities", ["provider", "provider_user_id", "deleted_at"], name: "provider_compound_key", unique: true, using: :btree
  add_index "oauth2_identities", ["user_id"], name: "index_oauth2_identities_on_user_id", using: :btree

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.string   "shortname"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "organizations", ["name"], name: "index_organizations_on_name", using: :btree
  add_index "organizations", ["shortname"], name: "index_organizations_on_shortname", using: :btree

  create_table "positions", force: true do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.string   "title"
    t.string   "department"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "positions", ["department"], name: "index_positions_on_department", using: :btree
  add_index "positions", ["title"], name: "index_positions_on_title", using: :btree

  create_table "project_competencies", force: true do |t|
    t.integer  "project_id"
    t.integer  "competency_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "project_ideas", force: true do |t|
    t.integer  "project_id"
    t.integer  "idea_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "project_ideas", ["created_at"], name: "index_project_ideas_on_created_at", using: :btree

  create_table "project_roles", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.boolean  "founder",    default: false
    t.boolean  "admin",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "project_roles", ["created_at"], name: "index_project_roles_on_created_at", using: :btree

  create_table "project_statuses", force: true do |t|
    t.string   "key"
    t.string   "name"
    t.text     "description"
    t.text     "icon"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "project_statuses", ["key"], name: "index_project_statuses_on_key", using: :btree

  create_table "projects", force: true do |t|
    t.integer  "project_status_id"
    t.string   "name"
    t.text     "pitch"
    t.text     "description"
    t.string   "website_url"
    t.string   "documentation_url"
    t.string   "source_url"
    t.string   "download_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "projects", ["created_at"], name: "index_projects_on_created_at", using: :btree

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "users", force: true do |t|
    t.text     "email",                               null: false
    t.integer  "primary_position_id"
    t.string   "name_first"
    t.string   "name_middle"
    t.string   "name_last",                           null: false
    t.string   "name_suffix"
    t.string   "website"
    t.string   "phone_number"
    t.string   "fax_number"
    t.text     "mailing_address"
    t.text     "biography"
    t.string   "social_google"
    t.string   "social_github"
    t.string   "social_linkedin"
    t.string   "social_twitter"
    t.boolean  "super_admin",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "password_hash"
  end

  add_index "users", ["created_at"], name: "index_users_on_created_at", using: :btree
  add_index "users", ["name_last", "name_first", "name_middle", "name_suffix"], name: "name", using: :btree
  add_index "users", ["primary_position_id"], name: "index_users_on_primary_position_id", using: :btree
  add_index "users", ["super_admin"], name: "index_users_on_super_admin", using: :btree

  add_foreign_key "event_groups", "events", name: "event_groups_event_id_fk"
  add_foreign_key "event_groups", "groups", name: "event_groups_group_id_fk"

end
