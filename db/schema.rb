# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_31_043754) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.boolean "deleted"
    t.integer "parent_id"
    t.integer "user_id"
    t.integer "video_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.integer "parent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "series_type"
    t.string "image_url"
    t.text "description"
    t.decimal "order"
    t.string "difficulty"
  end

  create_table "notifications", force: :cascade do |t|
    t.boolean "read"
    t.boolean "email_sent"
    t.integer "user_id"
    t.integer "comment_id"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "video_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "encrypted_password"
    t.string "salt"
    t.string "token"
    t.boolean "admin"
    t.boolean "email_weekly"
    t.boolean "email_daily"
    t.string "email_subscription_token"
    t.string "stripe_id"
    t.string "subscription_id"
    t.datetime "subscription_end_date"
    t.boolean "subscription_cancelled"
    t.string "plan_id"
    t.hstore "plan_hash", default: {}
    t.string "phone_number"
    t.hstore "next_steps_taken", default: {}
    t.boolean "free_subscription"
  end

  create_table "video_plays", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "video_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_video_plays_on_user_id"
    t.index ["video_id"], name: "index_video_plays_on_video_id"
  end

  create_table "video_tags", force: :cascade do |t|
    t.bigint "video_id"
    t.bigint "tag_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tag_id"], name: "index_video_tags_on_tag_id"
    t.index ["video_id"], name: "index_video_tags_on_video_id"
  end

  create_table "videos", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "thumbnail"
    t.string "videoUrl"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "duration"
    t.datetime "published_at"
    t.text "code_summary"
    t.bigint "course_id"
    t.decimal "order"
    t.boolean "pro"
    t.string "lesson_type"
    t.text "code"
    t.string "code_summary_state", default: "not_ready"
    t.index ["course_id"], name: "index_videos_on_course_id"
  end

  add_foreign_key "videos", "courses"
end
