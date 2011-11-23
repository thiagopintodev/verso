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

ActiveRecord::Schema.define(:version => 20111123131216) do

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
    t.string   "aud1_file_name"
    t.string   "aud1_content_type"
    t.integer  "aud1_file_size"
    t.datetime "aud1_updated_at"
    t.string   "aud2_file_name"
    t.string   "aud2_content_type"
    t.integer  "aud2_file_size"
    t.datetime "aud2_updated_at"
    t.string   "aud3_file_name"
    t.string   "aud3_content_type"
    t.integer  "aud3_file_size"
    t.datetime "aud3_updated_at"
    t.string   "aud4_file_name"
    t.string   "aud4_content_type"
    t.integer  "aud4_file_size"
    t.datetime "aud4_updated_at"
  end

  add_index "project_versions", ["project_id"], :name => "index_project_versions_on_project_id"
  add_index "project_versions", ["user_id"], :name => "index_project_versions_on_user_id"

  create_table "projects", :force => true do |t|
    t.integer  "user_id"
    t.integer  "subject_id"
    t.integer  "degree_id"
    t.integer  "numero",                 :default => 1
    t.integer  "project_versions_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "capa_file_name"
    t.string   "capa_content_type"
    t.integer  "capa_file_size"
    t.datetime "capa_updated_at"
    t.integer  "status_revisao_texto",   :default => 0
    t.integer  "status_revisao_final",   :default => 0
    t.integer  "status_revisao_audio",   :default => 0
    t.integer  "status_producao",        :default => 0
  end

  create_table "reviews", :force => true do |t|
    t.integer  "project_id"
    t.integer  "tipo"
    t.text     "texto"
    t.integer  "criou_user_id"
    t.datetime "criou_at"
    t.integer  "corrigiu_user_id"
    t.datetime "corrigiu_at"
    t.integer  "revisou_user_id"
    t.datetime "revisou_at"
    t.boolean  "revisou_aprovou",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",           :default => 0
  end

  add_index "reviews", ["project_id"], :name => "index_reviews_on_project_id"

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
