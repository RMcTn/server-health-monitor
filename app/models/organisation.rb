class Organisation < ApplicationRecord
  validates :name, presence: true
  has_many :servers
end
