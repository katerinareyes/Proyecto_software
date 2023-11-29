class AddDisponibilidadToJuegos < ActiveRecord::Migration[7.0]
  def change
    add_column :juegos, :disponibilidad, :boolean, default: true
  end
end
