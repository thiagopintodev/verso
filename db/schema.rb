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

ActiveRecord::Schema.define(:version => 20111101115644) do

  create_table "degrees", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_versions", :force => true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.text     "texto"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fla_file_name"
    t.string   "fla_content_type"
    t.integer  "fla_file_size"
    t.datetime "fla_updated_at"
    t.string   "swf1_file_name"
    t.string   "swf1_content_type"
    t.integer  "swf1_file_size"
    t.datetime "swf1_updated_at"
    t.string   "swf2_file_name"
    t.string   "swf2_content_type"
    t.integer  "swf2_file_size"
    t.datetime "swf2_updated_at"
    t.string   "swf3_file_name"
    t.string   "swf3_content_type"
    t.integer  "swf3_file_size"
    t.datetime "swf3_updated_at"
    t.string   "swf4_file_name"
    t.string   "swf4_content_type"
    t.integer  "swf4_file_size"
    t.datetime "swf4_updated_at"
  end

  add_index "project_versions", ["project_id"], :name => "index_project_versions_on_project_id"
  add_index "project_versions", ["user_id"], :name => "index_project_versions_on_user_id"

  create_table "projects", :force => true do |t|
    t.integer  "user_id"
    t.integer  "subject_id"
    t.integer  "degree_id"
    t.integer  "sequencia",         :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "capa_file_name"
    t.string   "capa_content_type"
    t.integer  "capa_file_size"
    t.datetime "capa_updated_at"
  end

  create_table "subjects", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
