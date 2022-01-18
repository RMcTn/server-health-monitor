class Server < ApplicationRecord
  validates :hostname, presence: true
  has_many :heartbeats, dependent: :destroy
  belongs_to :organisation
end
