# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100731064554) do

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "role"
    t.string   "business_type"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id",     :default => 0, :null => false
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "job_title"
    t.string   "email"
    t.string   "phone"
    t.string   "mobile"
    t.string   "portrait_url"
    t.text     "profile"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "flickr_url"
    t.string   "twitter_url"
    t.string   "facebook_url"
    t.string   "linked_in_url"
    t.string   "portrait_thumb_url"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id",  :default => 0, :null => false
  end

  create_table "responsibilities", :force => true do |t|
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id",  :default => 0, :null => false
  end

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.string   "course"
    t.string   "result"
    t.date     "date_from"
    t.date     "date_to"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id",  :default => 0, :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "skills", :force => true do |t|
    t.string   "name"
    t.string   "level"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id",   :default => 0, :null => false
  end

  create_table "tasks", :force => true do |t|
    t.text     "description"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
