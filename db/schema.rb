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

ActiveRecord::Schema.define(:version => 20140109065254) do

  create_table "logins", :force => true do |t|
    t.string   "hashed_password"
    t.string   "username"
    t.string   "usertype"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "managers", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "login_id"
    t.boolean  "sex"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "phonelocks", :force => true do |t|
    t.string   "token"
    t.boolean  "status"
    t.integer  "login_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "phones", :force => true do |t|
    t.string   "SDK"
    t.string   "deviceID"
    t.string   "versioncode"
    t.string   "model"
    t.string   "usertype"
    t.integer  "login_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "phonesoftlogs", :force => true do |t|
    t.string   "versioncode"
    t.datetime "updatetime"
    t.text     "softinfo"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "semesters", :force => true do |t|
    t.string   "name"
    t.datetime "begintime"
    t.datetime "endtime"
    t.boolean  "status"
    t.integer  "teacher_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "shclass_teachers", :force => true do |t|
    t.integer  "shclass_id"
    t.integer  "teacher_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "shclasses", :force => true do |t|
    t.string   "name"
    t.integer  "shgrade_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "simple_captcha_data", ["key"], :name => "idx_key"

  create_table "students", :force => true do |t|
    t.string   "name"
    t.integer  "shclass_id"
    t.integer  "point"
    t.string   "email"
    t.boolean  "sex"
    t.float    "height"
    t.float    "weight"
    t.integer  "login_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "phone"
    t.string   "studentid"
  end

  create_table "teachers", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "login_id"
    t.boolean  "sex"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
