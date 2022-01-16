class OrganisationsUser < ApplicationRecord
  belongs_to :organisation
  belongs_to :user

  after_create_commit {
    broadcast_append_to(organisation, target: "users", partial: 'users/user', locals: {user: user})
  }
end
