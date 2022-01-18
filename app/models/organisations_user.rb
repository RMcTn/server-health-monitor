class OrganisationsUser < ApplicationRecord
  belongs_to :organisation
  belongs_to :user

  after_create_commit {
    broadcast_append_to(organisation, target: "users", partial: 'users/user', locals: {organisation: organisation, user: user})
  }

  after_destroy_commit {
    user_dom_id = "user_" + user.id.to_s
    broadcast_remove_to(organisation, target: user_dom_id)
  }

end
