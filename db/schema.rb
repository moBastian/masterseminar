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

ActiveRecord::Schema.define(version: 20180530144657) do

  create_table "assessments", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "test_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fakenames", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.text     "feedbacktext"
    t.integer  "group_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "groups", force: :cascade do |t|
    t.text     "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archive"
    t.boolean  "demo"
    t.integer  "test_condition_count"
  end

  create_table "items", force: :cascade do |t|
    t.integer  "test_id"
    t.text     "shorthand"
    t.text     "itemtext"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "itemview"
    t.integer  "itemtype"
  end

  create_table "measurements", force: :cascade do |t|
    t.integer  "assessment_id"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stuId"
  end

  create_table "results", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "measurement_id"
    t.text     "items"
    t.text     "responses"
    t.float    "total"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "extra_data"
  end

  create_table "students", force: :cascade do |t|
    t.text     "name"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "gender"
    t.text     "login"
    t.integer  "group_type"
    t.text     "fingerprint"
    t.text     "ip"
    t.integer  "age"
    t.text     "email"
    t.text     "achievement"
    t.integer  "points"
    t.integer  "played_questions"
    t.text     "first_accept"
    t.integer  "login_times"
    t.boolean  "feedback_send"
    t.boolean  "survey_done"
  end

  create_table "tests", force: :cascade do |t|
    t.text     "name"
    t.text     "info"
    t.integer  "len"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "time"
    t.text     "short_info"
    t.text     "subject"
    t.text     "construct"
    t.text     "picture"
  end

  create_table "users", force: :cascade do |t|
    t.text     "email"
    t.text     "password_digest"
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "capabilities"
    t.datetime "tcaccept"
    t.datetime "last_login"
    t.integer  "account_type"
    t.integer  "state"
  end

end
