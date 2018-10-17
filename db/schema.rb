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

ActiveRecord::Schema.define(version: 2018_10_17_231552) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "configurations", force: :cascade do |t|
    t.text "key"
    t.text "value"
    t.text "location"
    t.bigint "system_node_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["system_node_id"], name: "index_configurations_on_system_node_id"
  end

  create_table "system_nodes", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "description"
    t.text "status_check_how_to"
    t.text "status_check_script"
    t.bigint "send_node_id"
    t.bigint "receive_node_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receive_node_id"], name: "index_system_nodes_on_receive_node_id"
    t.index ["send_node_id"], name: "index_system_nodes_on_send_node_id"
  end

end
