class AddAttributesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :nombre, :string
    add_column :users, :telefono, :integer
    add_column :users, :descripcion, :string 
  end
end
