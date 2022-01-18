class DashboardController < ApplicationController
  before_action :set_organisations
  before_action :authenticate_user!

  def show
  end

  def index
  end

  def set_organisations
    @organisations = current_user.organisations
  end
end
