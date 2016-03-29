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

ActiveRecord::Schema.define(version: 20160329193201) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.text "event_name"
  end

  create_table "ips", force: :cascade do |t|
    t.text "ip"
  end

  create_table "payload_requests", force: :cascade do |t|
    t.date    "requested_at"
    t.integer "responded_in"
    t.integer "url_id"
    t.integer "referrer_id"
    t.integer "request_type_id"
    t.integer "event_id"
    t.integer "user_agent_id"
    t.integer "resolution_id"
    t.integer "ip_id"
  end

  create_table "referrers", force: :cascade do |t|
    t.text "referred_by"
  end

  create_table "request_types", force: :cascade do |t|
    t.text "request_type"
  end

  create_table "resolutions", force: :cascade do |t|
    t.integer "resolution_width"
    t.integer "resolution_height"
  end

  create_table "urls", force: :cascade do |t|
    t.text "url"
  end

  create_table "user_agents", force: :cascade do |t|
    t.text "user_agent"
  end

end