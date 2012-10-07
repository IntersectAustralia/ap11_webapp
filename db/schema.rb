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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120921002656) do

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "experiments", :force => true do |t|
    t.text     "title"
    t.date     "date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "input_collections", :force => true do |t|
    t.string   "name",            :limit => 512
    t.text     "description"
    t.text     "license"
    t.text     "access_rights"
    t.text     "location"
    t.string   "for_code1"
    t.string   "for_code2"
    t.string   "for_code3"
    t.string   "website_name",    :limit => 512
    t.string   "url",             :limit => 2000
    t.integer  "experiment_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "collection_type"
  end

  create_table "output_collections", :force => true do |t|
    t.string   "name",          :limit => 512
    t.text     "description"
    t.text     "license"
    t.text     "access_rights"
    t.text     "location"
    t.string   "for_code1"
    t.string   "for_code2"
    t.string   "for_code3"
    t.string   "website_name",  :limit => 512
    t.string   "url",           :limit => 2000
    t.integer  "experiment_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "party_records", :force => true do |t|
    t.string   "abbreviation"
    t.string   "full_name"
    t.text     "description"
    t.text     "address"
    t.string   "url",           :limit => 2000
    t.string   "for_code1"
    t.string   "for_code2"
    t.string   "for_code3"
    t.text     "access_rights"
    t.text     "license"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "permissions", :force => true do |t|
    t.string   "entity"
    t.string   "action"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "research_subject_codes", :force => true do |t|
    t.string "subject_code"
    t.string "subject_name"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles_permissions", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "permission_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        :default => 0
    t.datetime "locked_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "status"
    t.integer  "role_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "title"
    t.text     "description"
    t.string   "home_page"
    t.string   "for_code1"
    t.string   "for_code2"
    t.string   "for_code3"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
