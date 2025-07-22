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

ActiveRecord::Schema[8.0].define(version: 2025_07_22_232819) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.string "text"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "ballots", force: :cascade do |t|
    t.bigint "voter_id", null: false
    t.jsonb "tally_payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["voter_id"], name: "index_ballots_on_voter_id", unique: true
  end

  create_table "elections", force: :cascade do |t|
    t.string "title"
    t.string "status", default: "pending"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "election_id", null: false
    t.string "prompt"
    t.string "question_type", default: "single_choice"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["election_id"], name: "index_questions_on_election_id"
  end

  create_table "voters", force: :cascade do |t|
    t.bigint "election_id", null: false
    t.string "email"
    t.string "name"
    t.string "access_token"
    t.datetime "ballot_cast_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["access_token"], name: "index_voters_on_access_token", unique: true
    t.index ["election_id"], name: "index_voters_on_election_id"
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "ballots", "voters"
  add_foreign_key "questions", "elections"
  add_foreign_key "voters", "elections"
end
