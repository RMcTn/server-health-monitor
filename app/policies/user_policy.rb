class UserPolicy < ApplicationPolicy
  attr_reader :current_user, :user

  def initialize(current_user, user)
    @current_user = current_user
    @user = user
  end

  def index?
    false
  end

  def show?
    @current_user == @user
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    @current_user == @user
  end

  def edit?
    update?
  end

  def destroy?
    @current_user == @user
  end

end
