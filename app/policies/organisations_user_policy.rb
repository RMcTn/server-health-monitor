class OrganisationsUserPolicy < ApplicationPolicy
  attr_reader :user, :organisation

  def initialize(user, organisation)
    @user = user
    @organisation = organisation
  end

  def index?
    @organisation.users.include?(@user)
  end

  def show?
    @organisation.users.include?(@user)
  end

  def create?
    @organisation.users.include?(@user)
  end

  def new?
    create?
  end

  def update?
    @organisation.users.include?(@user)
  end

  def edit?
    update?
  end

  def destroy?
    @organisation.users.include?(@user)
  end

end
