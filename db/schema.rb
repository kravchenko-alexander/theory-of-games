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

ActiveRecord::Schema.define(version: 20180602175050) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "alternatives", force: :cascade do |t|
    t.string "name"
  end

  create_table "criterions", force: :cascade do |t|
    t.string "name"
    t.string "c_type"
    t.string "optim_type"
    t.string "measure"
    t.string "scale_type"
  end

  create_table "expert_alternative_ranks", force: :cascade do |t|
    t.bigint "expert_id"
    t.bigint "alternative_id"
    t.integer "rank"
    t.index ["alternative_id"], name: "index_expert_alternative_ranks_on_alternative_id"
    t.index ["expert_id"], name: "index_expert_alternative_ranks_on_expert_id"
  end

  create_table "expert_criterion_marks", force: :cascade do |t|
    t.bigint "expert_id"
    t.bigint "criterion_id"
    t.float "value"
    t.index ["criterion_id"], name: "index_expert_criterion_marks_on_criterion_id"
    t.index ["expert_id"], name: "index_expert_criterion_marks_on_expert_id"
  end

  create_table "experts", force: :cascade do |t|
    t.string "name"
  end

  create_table "marks", force: :cascade do |t|
    t.string "name"
    t.bigint "criterion_id"
    t.float "norm_mark", default: 1.0
    t.index ["criterion_id"], name: "index_marks_on_criterion_id"
  end

  create_table "vectors", force: :cascade do |t|
    t.bigint "alternative_id"
    t.bigint "mark_id"
    t.index ["alternative_id"], name: "index_vectors_on_alternative_id"
    t.index ["mark_id"], name: "index_vectors_on_mark_id"
  end

end
