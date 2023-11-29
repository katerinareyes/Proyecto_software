class Juego < ApplicationRecord
  validates :nombre, presence: true
  validates :tipo, presence: true
  validates :estado, presence: true
  validates :cant_jugadores, presence: true
  validates :imagen, presence: true
  belongs_to :user
  has_many :solicituds, as: :solicitable
  has_many :solicituds, as: :ofreciable
end
