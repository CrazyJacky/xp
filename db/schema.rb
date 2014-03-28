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

ActiveRecord::Schema.define(version: 20140325235123) do

  create_table "lesson_tags", force: true do |t|
    t.integer  "lesson_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lesson_tags", ["lesson_id"], name: "index_lesson_tags_on_lesson_id"
  add_index "lesson_tags", ["tag_id"], name: "index_lesson_tags_on_tag_id"

  create_table "lessons", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "references"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_lessons", force: true do |t|
    t.integer  "user_id"
    t.integer  "lesson_id"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_lessons", ["lesson_id"], name: "index_user_lessons_on_lesson_id"
  add_index "user_lessons", ["user_id"], name: "index_user_lessons_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end