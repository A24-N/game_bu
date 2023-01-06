# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_01_06_061516) do

  create_table "comments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.text "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_favorites_on_post_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "introduces", force: :cascade do |t|
    t.integer "introduce_from_user_id"
    t.integer "introduce_to_user_id"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["introduce_from_user_id"], name: "index_introduces_on_introduce_from_user_id"
    t.index ["introduce_to_user_id"], name: "index_introduces_on_introduce_to_user_id"
  end

  create_table "matches", force: :cascade do |t|
    t.integer "user_id"
    t.integer "room_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["room_id"], name: "index_matches_on_room_id"
    t.index ["user_id"], name: "index_matches_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "user_id"
    t.integer "room_id"
    t.text "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["room_id"], name: "index_messages_on_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "post_tag_relations", force: :cascade do |t|
    t.integer "post_id"
    t.integer "tag_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_post_tag_relations_on_post_id"
    t.index ["tag_id"], name: "index_post_tag_relations_on_tag_id"
  end

  create_table "posts", force: :cascade do |t|
    t.integer "user_id"
    t.string "title", null: false
    t.text "body", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follow_id"
    t.integer "follower_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["follow_id"], name: "index_relationships_on_follow_id"
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_rooms_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "nickname", null: false
    t.text "introduction"
    t.integer "playstyle", default: 0
    t.string "activetime"
    t.boolean "is_user_deleted", default: false, null: false
    t.boolean "admin_status", default: false, null: false
    t.integer "matching_status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "favorites", "posts"
  add_foreign_key "favorites", "users"
  add_foreign_key "introduces", "introduce_from_users"
  add_foreign_key "introduces", "introduce_to_users"
  add_foreign_key "matches", "rooms"
  add_foreign_key "matches", "users"
  add_foreign_key "messages", "rooms"
  add_foreign_key "messages", "users"
  add_foreign_key "post_tag_relations", "posts"
  add_foreign_key "post_tag_relations", "tags"
  add_foreign_key "posts", "users"
  add_foreign_key "relationships", "followers"
  add_foreign_key "relationships", "follows"
  add_foreign_key "rooms", "users"
end
