class OrganisationsUser < ApplicationRecord
  belongs_to :organisation
  belongs_to :user

  # TODO: Add db unique index for this
  validates :user, uniqueness: { scope: :organisation, message: "is already a member of this organisation" }

  after_create_commit {
    broadcast_append_to(organisation, target: "users", partial: 'users/user', locals: {organisation: organisation, user: user})
  }

  after_destroy_commit {
    user_dom_id = "user_" + user.id.to_s
    broadcast_remove_to(organisation, target: user_dom_id)
  }

end
