class Organisation < ApplicationRecord
  validates :name, presence: true
  has_many :servers
  has_many :organisations_users
  has_many :users, through: :organisations_users
end
