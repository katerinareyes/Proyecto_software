class CreateLibros < ActiveRecord::Migration[7.0]
  def change
    create_table :libros do |t|
      t.text :titulo
      t.text :autor
      t.text :estado
      t.integer :paginas
      t.integer :edicion
      t.text :editorial
      t.text :tapa
      t.text :descripcion
      t.text :imagen
      t.belongs_to :user, null:false, foreign_key: true
      
      t.timestamps
    end
  end
end
