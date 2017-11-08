class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.string :nombre
      t.string :apellido
      t.string :email
      t.string :titulo
      t.text :descripcion
      t.string :video_source
      t.string :video_out
      t.boolean :estado
      t.boolean :convirtiendo
      t.references :concurso, foreign_key: true
      t.timestamps
    end
  end
end
