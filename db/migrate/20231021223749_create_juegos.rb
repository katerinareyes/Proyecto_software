class CreateJuegos < ActiveRecord::Migration[7.0]
  def change
    create_table :juegos do |t|
      t.text :nombre
      t.text :tipo
      t.text :estado
      t.integer :cant_jugadores
      t.text :descripcion
      t.text :imagen
      t.belongs_to :user, null:false, foreign_key: true
      
      t.timestamps
    end
  end
end
