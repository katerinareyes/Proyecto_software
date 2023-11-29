class AddUserIdToLibros < ActiveRecord::Migration[7.0]
  def change
    add_reference :libros, :user, null: true, foreign_key: true
  end
end
