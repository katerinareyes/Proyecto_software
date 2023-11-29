class Solicitud < ApplicationRecord
  belongs_to :solicitable, polymorphic: true
  belongs_to :ofreciable, polymorphic: true

end
