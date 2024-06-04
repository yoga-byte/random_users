# frozen_string_literal: true

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

ActiveRecord::Schema[7.1].define(version: 20_240_603_143_735) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'daily_recods', primary_key: 'date', id: :date, force: :cascade do |t|
    t.integer 'male_count'
    t.integer 'female_count'
    t.integer 'male_avg_age'
    t.integer 'female_avg_age'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'daily_records', primary_key: 'date', id: :date, force: :cascade do |t|
    t.integer 'male_count'
    t.integer 'female_count'
    t.float 'male_avg_age'
    t.float 'female_avg_age'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', primary_key: 'uuid', id: :string, force: :cascade do |t|
    t.string 'gender'
    t.jsonb 'name'
    t.jsonb 'location'
    t.integer 'age'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
