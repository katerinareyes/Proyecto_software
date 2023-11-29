class CreateSolicituds < ActiveRecord::Migration[7.0]
  def change
    create_table :solicituds do |t|
      t.string :estado, default:"pendiente"
      t.references :solicitable, polymorphic: true
      t.references :ofreciable, polymorphic: true

      t.timestamps
    end
  end
end
