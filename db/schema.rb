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

ActiveRecord::Schema.define(version: 2018_12_31_080334) do

  create_table "links", force: :cascade do |t|
    t.float "corr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "node_links", force: :cascade do |t|
    t.integer "node_id"
    t.integer "link_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["link_id"], name: "index_node_links_on_link_id"
    t.index ["node_id"], name: "index_node_links_on_node_id"
  end

  create_table "nodes", force: :cascade do |t|
    t.string "word"
    t.float "freq"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "trend_id"
    t.index ["trend_id"], name: "index_nodes_on_trend_id"
  end

  create_table "trends", force: :cascade do |t|
    t.string "label"
    t.date "collected"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end