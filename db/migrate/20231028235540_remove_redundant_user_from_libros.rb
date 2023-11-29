class RemoveRedundantUserFromLibros < ActiveRecord::Migration[7.0]
  def change
    remove_column :libros, :user
  end
end
