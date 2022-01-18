class OrganisationsUsersController < ApplicationController
  before_action :set_organisation, only: %i[ new create edit update destroy ]

   def new
     @organisations_user = OrganisationsUser.new
   end

   def create
    email = params[:organisations_user][:email]
    @user = User.find_by(email: email)
    if @user == nil 
      redirect_to new_organisation_organisations_user_path(@organisation), alert: email + " could not be found"
      return
    end

    # TODO: Check for existing entry (maybe just do @organisation.users.create(@user) avoids duplicates i think)
    @organisations_user = OrganisationsUser.create(organisation_id: @organisation.id, user_id: @user.id)
    if @organisations_user.save
      redirect_to organisation_path(@organisation), notice: @user.email + " was successfully added" 
    else
      render :new, status: :unprocessable_entity
    end
   end

   def destroy
    @user = User.find(params[:user_id])
    if @user == nil 
      redirect_to organisation_path(@organisation), notice: params[:email] + " was removed"
      return
    end

    @organisations_user = OrganisationsUser.find_by(organisation_id: @organisation.id, user_id: @user.id)
    @organisations_user.destroy

    redirect_to organisation_path(@organisation), notice: params[:email] + " was removed"
     
   end

    def set_organisation
      @organisation = Organisation.find(params[:organisation_id])
    end
end

