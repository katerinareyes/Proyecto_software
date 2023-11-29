class RemoveRedundantUserFromJuegos < ActiveRecord::Migration[7.0]
  def change
    remove_column :juegos, :user
  end
end
