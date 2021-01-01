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

ActiveRecord::Schema.define(version: 2021_01_01_011917) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "assignments", force: :cascade do |t|
    t.bigint "course_id"
    t.string "name"
    t.integer "status"
    t.float "adjustment_factor_cap"
    t.decimal "full_grade"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_assignments_on_course_id"
  end

  create_table "assignments_students", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "assignment_id"
    t.float "individual_average"
    t.float "adjustment_factor"
    t.float "individual_project_grade"
    t.float "grade"
    t.string "rank"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "individual_grade", default: 0.0
    t.index ["assignment_id"], name: "index_assignments_students_on_assignment_id"
    t.index ["student_id"], name: "index_assignments_students_on_student_id"
  end

  create_table "assignments_teams", force: :cascade do |t|
    t.bigint "assignment_id"
    t.bigint "team_id"
    t.decimal "grade"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["assignment_id"], name: "index_assignments_teams_on_assignment_id"
    t.index ["team_id"], name: "index_assignments_teams_on_team_id"
  end

  create_table "courses", force: :cascade do |t|
    t.bigint "session_id"
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["session_id"], name: "index_courses_on_session_id"
  end

  create_table "courses_students", force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "student_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id", "student_id"], name: "index_courses_students_on_course_id_and_student_id", unique: true
    t.index ["course_id"], name: "index_courses_students_on_course_id"
    t.index ["student_id"], name: "index_courses_students_on_student_id"
  end

  create_table "ranks", force: :cascade do |t|
    t.bigint "assignment_id"
    t.integer "ranker_id"
    t.integer "receiver_id"
    t.integer "rating"
    t.text "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["assignment_id"], name: "index_ranks_on_assignment_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "admin_user_id"
    t.string "title"
    t.boolean "default_session", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_user_id"], name: "index_sessions_on_admin_user_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "raw_password"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "student_id", null: false
    t.string "name"
    t.string "github_id"
    t.string "password_reset_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_students_on_email", unique: true
    t.index ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true
  end

  create_table "students_teams", force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "student_id"
    t.bigint "team_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id", "student_id", "team_id"], name: "index_students_teams_on_course_id_and_student_id_and_team_id", unique: true
    t.index ["course_id"], name: "index_students_teams_on_course_id"
    t.index ["student_id"], name: "index_students_teams_on_student_id"
    t.index ["team_id"], name: "index_students_teams_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.bigint "course_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "team_grade", default: 0.0
    t.index ["course_id"], name: "index_teams_on_course_id"
  end

end
