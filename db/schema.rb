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

ActiveRecord::Schema[7.0].define(version: 2023_10_28_180937) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "juegos", force: :cascade do |t|
    t.text "nombre"
    t.text "tipo"
    t.text "estado"
    t.integer "cant_jugadores"
    t.text "descripcion"
    t.text "imagen"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "disponibilidad", default: "Disponible"
    t.index ["user_id"], name: "index_juegos_on_user_id"
  end

  create_table "libros", force: :cascade do |t|
    t.text "titulo"
    t.text "autor"
    t.text "estado"
    t.integer "paginas"
    t.integer "edicion"
    t.text "editorial"
    t.text "tapa"
    t.text "descripcion"
    t.text "imagen"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "disponibilidad", default: "Disponible"
    t.index ["user_id"], name: "index_libros_on_user_id"
  end

  create_table "resenas", force: :cascade do |t|
    t.integer "calificacion"
    t.text "comentario"
    t.bigint "usuario_creador_id", null: false
    t.bigint "usuario_receptor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["usuario_creador_id"], name: "index_resenas_on_usuario_creador_id"
    t.index ["usuario_receptor_id"], name: "index_resenas_on_usuario_receptor_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.boolean "is_private"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "solicituds", force: :cascade do |t|
    t.string "estado", default: "pendiente"
    t.string "solicitable_type"
    t.bigint "solicitable_id"
    t.string "ofreciable_type"
    t.bigint "ofreciable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ofreciable_type", "ofreciable_id"], name: "index_solicituds_on_ofreciable"
    t.index ["solicitable_type", "solicitable_id"], name: "index_solicituds_on_solicitable"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nombre"
    t.integer "telefono"
    t.string "descripcion"
    t.integer "rol", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "juegos", "users"
  add_foreign_key "libros", "users"
  add_foreign_key "resenas", "users", column: "usuario_creador_id"
  add_foreign_key "resenas", "users", column: "usuario_receptor_id"
end
