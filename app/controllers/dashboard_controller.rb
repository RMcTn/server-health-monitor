class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organisations

  def show
  end

  def index
  end

  def set_organisations
    @organisations = current_user.organisations
  end
end
