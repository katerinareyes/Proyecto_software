class Libro < ApplicationRecord
  validates :titulo, presence: true
  validates :autor, presence: true
  validates :estado, presence: true
  validates :paginas, presence: true
  validates :imagen, presence: true
  belongs_to :user
  has_many :solicituds, as: :solicitable
  has_many :solicituds, as: :ofreciable
end
