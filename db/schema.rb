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

ActiveRecord::Schema[8.1].define(version: 2026_02_28_210701) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "clients", force: :cascade do |t|
    t.text "address"
    t.datetime "created_at", null: false
    t.string "document_number"
    t.string "document_type", default: "DNI"
    t.string "email"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.text "notes"
    t.string "phone"
    t.bigint "studio_id", null: false
    t.datetime "updated_at", null: false
    t.index ["studio_id", "document_number"], name: "index_clients_on_studio_id_and_document_number", unique: true
    t.index ["studio_id"], name: "index_clients_on_studio_id"
  end

  create_table "deadlines", force: :cascade do |t|
    t.integer "alert_days_before", default: 2
    t.boolean "alert_sent", default: false
    t.boolean "business_days", default: true
    t.date "completed_on"
    t.datetime "created_at", null: false
    t.integer "days_count"
    t.string "depends_on_event"
    t.text "description"
    t.date "due_on", null: false
    t.date "event_date"
    t.boolean "event_occurred", default: false
    t.bigint "expediente_id", null: false
    t.bigint "parent_deadline_id"
    t.integer "party", default: 0, null: false
    t.integer "priority", default: 0
    t.bigint "procedural_act_id"
    t.date "starts_on"
    t.integer "status", default: 0, null: false
    t.bigint "studio_id", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["expediente_id", "status"], name: "index_deadlines_on_expediente_id_and_status"
    t.index ["expediente_id"], name: "index_deadlines_on_expediente_id"
    t.index ["parent_deadline_id"], name: "index_deadlines_on_parent_deadline_id"
    t.index ["party"], name: "index_deadlines_on_party"
    t.index ["procedural_act_id"], name: "index_deadlines_on_procedural_act_id"
    t.index ["status"], name: "index_deadlines_on_status"
    t.index ["studio_id", "due_on"], name: "index_deadlines_on_studio_id_and_due_on"
    t.index ["studio_id"], name: "index_deadlines_on_studio_id"
  end

  create_table "expedientes", force: :cascade do |t|
    t.bigint "assigned_to_id"
    t.string "caratula", null: false
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.text "descripcion"
    t.date "fecha_inicio"
    t.string "fuero"
    t.string "jurisdiccion", default: "Nacional"
    t.string "juzgado"
    t.string "materia"
    t.string "moneda", default: "ARS"
    t.decimal "monto_reclamado", precision: 15, scale: 2
    t.string "numero_causa"
    t.string "parte", default: "actor"
    t.integer "status", default: 0, null: false
    t.bigint "studio_id", null: false
    t.string "tipo_proceso"
    t.datetime "updated_at", null: false
    t.index ["assigned_to_id"], name: "index_expedientes_on_assigned_to_id"
    t.index ["client_id"], name: "index_expedientes_on_client_id"
    t.index ["fuero"], name: "index_expedientes_on_fuero"
    t.index ["status"], name: "index_expedientes_on_status"
    t.index ["studio_id", "numero_causa"], name: "index_expedientes_on_studio_id_and_numero_causa"
    t.index ["studio_id"], name: "index_expedientes_on_studio_id"
  end

  create_table "movements", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.bigint "expediente_id", null: false
    t.string "movement_type"
    t.datetime "occurred_at", null: false
    t.bigint "studio_id", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["expediente_id", "occurred_at"], name: "index_movements_on_expediente_id_and_occurred_at"
    t.index ["expediente_id"], name: "index_movements_on_expediente_id"
    t.index ["studio_id"], name: "index_movements_on_studio_id"
    t.index ["user_id"], name: "index_movements_on_user_id"
  end

  create_table "procedural_acts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.date "fecha_acto"
    t.string "name", null: false
    t.integer "position", default: 0
    t.bigint "procedural_instance_id", null: false
    t.integer "status", default: 0
    t.bigint "studio_id", null: false
    t.datetime "updated_at", null: false
    t.index ["procedural_instance_id"], name: "index_procedural_acts_on_procedural_instance_id"
    t.index ["studio_id"], name: "index_procedural_acts_on_studio_id"
  end

  create_table "procedural_instances", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "expediente_id", null: false
    t.date "fecha_fin"
    t.date "fecha_inicio"
    t.integer "instance_type", default: 0
    t.string "name", null: false
    t.integer "position", default: 0
    t.integer "status", default: 0
    t.bigint "studio_id", null: false
    t.string "tribunal"
    t.datetime "updated_at", null: false
    t.index ["expediente_id"], name: "index_procedural_instances_on_expediente_id"
    t.index ["studio_id"], name: "index_procedural_instances_on_studio_id"
  end

  create_table "studios", force: :cascade do |t|
    t.text "address"
    t.datetime "created_at", null: false
    t.string "cuit"
    t.string "email"
    t.string "name", null: false
    t.jsonb "notification_preferences", default: {}
    t.string "phone"
    t.string "plan", default: "free"
    t.string "slug", null: false
    t.string "timezone", default: "Buenos Aires"
    t.datetime "updated_at", null: false
    t.index ["cuit"], name: "index_studios_on_cuit", unique: true
    t.index ["slug"], name: "index_studios_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "matricula"
    t.string "phone"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "role", default: 0, null: false
    t.bigint "studio_id", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["studio_id"], name: "index_users_on_studio_id"
  end

  create_table "versions", force: :cascade do |t|
    t.datetime "created_at"
    t.string "event", null: false
    t.bigint "item_id", null: false
    t.string "item_type", null: false
    t.text "object"
    t.string "whodunnit"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "clients", "studios"
  add_foreign_key "deadlines", "deadlines", column: "parent_deadline_id"
  add_foreign_key "deadlines", "expedientes"
  add_foreign_key "deadlines", "procedural_acts"
  add_foreign_key "deadlines", "studios"
  add_foreign_key "expedientes", "clients"
  add_foreign_key "expedientes", "studios"
  add_foreign_key "expedientes", "users", column: "assigned_to_id"
  add_foreign_key "movements", "expedientes"
  add_foreign_key "movements", "studios"
  add_foreign_key "movements", "users"
  add_foreign_key "procedural_acts", "procedural_instances"
  add_foreign_key "procedural_acts", "studios"
  add_foreign_key "procedural_instances", "expedientes"
  add_foreign_key "procedural_instances", "studios"
  add_foreign_key "users", "studios"
end
