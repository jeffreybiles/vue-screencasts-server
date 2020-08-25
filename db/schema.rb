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

ActiveRecord::Schema.define(version: 2020_08_25_060642) do

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

  create_table "training_completions", force: :cascade do |t|
    t.bigint "training_item_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["training_item_id"], name: "index_training_completions_on_training_item_id"
    t.index ["user_id"], name: "index_training_completions_on_user_id"
  end

  create_table "training_courses", force: :cascade do |t|
    t.string "name"
    t.string "external_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "training_courses_modules", id: false, force: :cascade do |t|
    t.bigint "training_course_id", null: false
    t.bigint "training_module_id", null: false
  end

  create_table "training_items", force: :cascade do |t|
    t.string "title"
    t.string "exercise_type"
    t.text "text"
    t.decimal "position"
    t.bigint "training_section_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "vimeo_uid"
    t.string "youtube_uid"
    t.string "video_url"
    t.boolean "published", default: true
    t.text "answer"
    t.index ["training_section_id"], name: "index_training_items_on_training_section_id"
  end

  create_table "training_modules", force: :cascade do |t|
    t.string "name"
    t.integer "week_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "intro"
    t.string "state", default: "published"
  end

  create_table "training_sections", force: :cascade do |t|
    t.string "name"
    t.decimal "position"
    t.bigint "training_module_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["training_module_id"], name: "index_training_sections_on_training_module_id"
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
    t.integer "plan_seats"
    t.string "active_campaign_id"
    t.boolean "bootcamp"
    t.decimal "playback_rate", default: "1.0"
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
