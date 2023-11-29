class Resena < ApplicationRecord
  belongs_to :usuario_creador, class_name: "User"
  belongs_to :usuario_receptor, class_name: "User"
end
