class AddDisponibilidadToLibros < ActiveRecord::Migration[7.0]
  def change
    add_column :libros, :disponibilidad, :boolean, default: true
  end
end
