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

ActiveRecord::Schema.define(:version => 20121013000514) do

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "author_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.boolean  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "picture_categories", :force => true do |t|
    t.integer  "category_id"
    t.integer  "picture_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "picture_categories", ["category_id"], :name => "index_picture_categories_on_category_id"
  add_index "picture_categories", ["picture_id"], :name => "index_picture_categories_on_picture_id"

  create_table "pictures", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "category_id"
    t.boolean  "status"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "pictures", ["category_id"], :name => "index_pictures_on_category_id"

  create_table "rankings", :force => true do |t|
    t.integer  "user_id"
    t.float    "score"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "rankings", ["user_id"], :name => "index_rankings_on_user_id"

  create_table "specials", :force => true do |t|
    t.string   "name"
    t.float    "price"
    t.string   "identifier"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_specials", :force => true do |t|
    t.integer  "user_id"
    t.integer  "special_id"
    t.string   "name"
    t.integer  "qtt"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_specials", ["special_id"], :name => "index_user_specials_on_special_id"
  add_index "user_specials", ["user_id"], :name => "index_user_specials_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "nickname"
    t.string   "image"
    t.float    "score",      :default => 0.0
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.float    "coins",      :default => 0.0
  end

end
