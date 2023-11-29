class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  msj1 = "debe tener 9 dígitos"
  msj2 = 'debe contener al menos un número'
  validates :nombre, presence: true
  validates :descripcion, presence: true, length: { maximum: 255 }
  validates :telefono, presence: true, numericality: { only_integer: true }, format: { with: /\A\d{9}\z/, message: msj1}
  validates :password, presence: true, length: { in: 6..12 }, format: { with: /\d/, message:msj2 }

  has_many :libros, dependent: :destroy
  has_many :juegos, dependent: :destroy
  has_many :usuario_creador_resenas, class_name: "Resena", foreign_key: "usuario_creador_id"
  has_many :usuario_receptor_resenas, class_name: "Resena", foreign_key: "usuario_receptor_id"

end
