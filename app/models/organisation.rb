class Organisation < ApplicationRecord
  validates :name, presence: true
  has_many :servers, dependent: :destroy
  has_many :organisations_users, dependent: :destroy
  has_many :users, through: :organisations_users

  def servers_with_recent_problems
    # TODO SPEEDUP Check the db impact of this
    servers.order(updated_at: :desc).select { |server| server.recent_failure? }

  end

  def servers_with_immediate_problem
    servers.order(updated_at: :desc).select { |server| server.last_request_failed? }
  end
end
