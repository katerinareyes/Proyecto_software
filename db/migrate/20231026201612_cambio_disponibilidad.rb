class CambioDisponibilidad < ActiveRecord::Migration[7.0]
  def change
    change_column :libros, :disponibilidad, :string, default: "Disponible"
    change_column :juegos, :disponibilidad, :string, default: "Disponible"
  end
end
