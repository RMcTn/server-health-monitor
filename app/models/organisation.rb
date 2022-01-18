class Organisation < ApplicationRecord
  validates :name, presence: true
  has_many :servers, dependent: :destroy
  has_many :organisations_users, dependent: :destroy
  has_many :users, through: :organisations_users

  def servers_with_problems
    # Loop through the servers, look for any with an error
    # Could we not just make an sql query for servers with org id == this one + status_code one of 0 or 500 etc?
    # TODO
    servers.each

  end
end
