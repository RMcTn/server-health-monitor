class OrganisationPolicy < ApplicationPolicy
  attr_reader :user, :organisation

  def initialize(user, organisation)
    @user = user
    @organisation = organisation
  end

  def index?
    true
  end


  def problems?
    @organisation.users.include?(@user)
  end

  def warnings?
    @organisation.users.include?(@user)
  end

  def healthy?
    @organisation.users.include?(@user)
  end

  def show?
    @organisation.users.include?(@user)
  end

  def create?
    true
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
