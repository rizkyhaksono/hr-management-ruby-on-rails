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

ActiveRecord::Schema[7.2].define(version: 2026_03_01_000002) do
  create_table "activities", force: :cascade do |t|
    t.string "action", null: false
    t.string "trackable_type"
    t.integer "trackable_id"
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_activities_on_created_at"
    t.index ["trackable_type", "trackable_id"], name: "index_activities_on_trackable_type_and_trackable_id"
  end

  create_table "attendances", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.date "date", null: false
    t.datetime "check_in"
    t.datetime "check_out"
    t.integer "status", default: 0, null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_attendances_on_date"
    t.index ["employee_id", "date"], name: "index_attendances_on_employee_id_and_date", unique: true
    t.index ["employee_id"], name: "index_attendances_on_employee_id"
    t.index ["status"], name: "index_attendances_on_status"
  end

  create_table "employees", force: :cascade do |t|
    t.string "employee_id", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "phone"
    t.string "department", null: false
    t.string "position", null: false
    t.date "hire_date", null: false
    t.decimal "salary", precision: 12, scale: 2, default: "0.0"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "leave_quota", default: 12, null: false
    t.index ["department"], name: "index_employees_on_department"
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["employee_id"], name: "index_employees_on_employee_id", unique: true
    t.index ["status"], name: "index_employees_on_status"
  end

  create_table "leaves", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.integer "leave_type", default: 0, null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.text "reason"
    t.integer "status", default: 0, null: false
    t.string "approved_by"
    t.integer "days_count", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_leaves_on_employee_id"
    t.index ["leave_type"], name: "index_leaves_on_leave_type"
    t.index ["start_date", "end_date"], name: "index_leaves_on_start_date_and_end_date"
    t.index ["status"], name: "index_leaves_on_status"
  end

  add_foreign_key "attendances", "employees"
  add_foreign_key "leaves", "employees"
end
