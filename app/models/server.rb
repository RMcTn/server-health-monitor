class Server < ApplicationRecord
  validates :hostname, presence: true
  has_many :heartbeats
  belongs_to :organisation
end
