class AddUserIdToJuegos < ActiveRecord::Migration[7.0]
  def change
    add_reference :juegos, :user, null: true, foreign_key: true
  end
end
