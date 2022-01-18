class Organisation < ApplicationRecord
  validates :name, presence: true
  has_many :servers, dependent: :destroy
  has_many :organisations_users, dependent: :destroy
  has_many :users, through: :organisations_users
end
