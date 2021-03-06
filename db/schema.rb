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

ActiveRecord::Schema.define(version: 20171008043928) do

  create_table "concursos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "nombre"
    t.string "imagen"
    t.string "url"
    t.date "fechaInicio"
    t.date "fechaFin"
    t.text "descripcion"
    t.bigint "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["usuario_id", "created_at"], name: "index_concursos_on_usuario_id_and_created_at"
    t.index ["usuario_id"], name: "index_concursos_on_usuario_id"
  end

  create_table "usuarios", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "nombre"
    t.string "apellido"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_usuarios_on_email", unique: true
  end

  create_table "videos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "nombre"
    t.string "apellido"
    t.string "email"
    t.string "titulo"
    t.text "descripcion"
    t.string "video_source"
    t.string "video_out"
    t.boolean "estado", default: false
    t.boolean "convirtiendo", default: false
    t.bigint "concurso_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["concurso_id"], name: "index_videos_on_concurso_id"
  end

  add_foreign_key "concursos", "usuarios"
  add_foreign_key "videos", "concursos"
end
