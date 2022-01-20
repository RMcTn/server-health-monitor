class OrganisationsUsersController < ApplicationController
  before_action :set_organisation, only: %i[ index new create edit update destroy ]
  before_action :authenticate_user!

  def index 
    authorize @organisation, policy_class: OrganisationsUserPolicy
    @organisations_users = @organisation.users
  end

   def new
     authorize @organisation, policy_class: OrganisationsUserPolicy
     @organisations_user = OrganisationsUser.new
   end

   def create
    authorize @organisation, policy_class: OrganisationsUserPolicy
    email = params[:organisations_user][:email]
    @user = User.find_by(email: email)
    if @user == nil 
      redirect_to new_organisation_organisations_user_path(@organisation), alert: email + " could not be found"
      return
    end

    @organisations_user = OrganisationsUser.create(organisation_id: @organisation.id, user_id: @user.id)
    if @organisations_user.save
      redirect_to organisation_organisations_users_path(@organisation), notice: @user.email + " was successfully added" 
    else
      render :new, status: :unprocessable_entity
    end
   end

   def destroy
    authorize @organisation, policy_class: OrganisationsUserPolicy
    @user = User.find(params[:user_id])
    if @user == nil 
      redirect_to organisation_path(@organisation), notice: params[:email] + " was removed"
      return
    end

    @organisations_user = OrganisationsUser.find_by(organisation_id: @organisation.id, user_id: @user.id)
    @organisations_user.destroy

    redirect_to organisation_organisations_users_path(@organisation), notice: params[:email] + " was removed"
     
   end

    def set_organisation
      @organisation = Organisation.find(params[:organisation_id])
    end
end

