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

ActiveRecord::Schema.define(version: 2019_06_06_131118) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "endorsements", force: :cascade do |t|
    t.integer "endorser_id"
    t.bigint "user_skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["endorser_id", "user_skill_id"], name: "index_endorsements_on_endorser_id_and_user_skill_id"
    t.index ["endorser_id"], name: "index_endorsements_on_endorser_id"
    t.index ["user_skill_id"], name: "index_endorsements_on_user_skill_id"
  end

  create_table "skill_tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_skill_tags_on_name", unique: true
  end

  create_table "user_skills", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "endorsements_count", default: 0
    t.bigint "skill_tag_id"
    t.index ["name", "user_id"], name: "index_user_skills_on_name_and_user_id"
    t.index ["skill_tag_id"], name: "index_user_skills_on_skill_tag_id"
    t.index ["user_id"], name: "index_user_skills_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "endorsements", "user_skills"
  add_foreign_key "user_skills", "skill_tags"
  add_foreign_key "user_skills", "users"
end
