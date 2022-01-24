class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organisations

  def show
  end

  def index
    @problem_servers = []
    @organisations.each do |org|
      servers = org.servers_with_immediate_problem
      if servers.length == 0
        next
      end
      org_servers = {}
      org_servers[:organisation] = org
      org_servers[:servers] = servers
      @problem_servers << org_servers
    end
  end

  def set_organisations
    @organisations = current_user.organisations
  end
end
