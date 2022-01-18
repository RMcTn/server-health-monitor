class OrganisationsController < ApplicationController
  before_action :set_organisation, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /organisations or /organisations.json
  def index
    @organisations = current_user.organisations
  end

  # GET /organisations/1 or /organisations/1.json
  def show
    authorize @organisation
  end

  # GET /organisations/new
  def new
    @organisation = Organisation.new
    authorize @organisation
  end

  # GET /organisations/1/edit
  def edit
    authorize @organisation
  end

  # POST /organisations or /organisations.json
  def create
    @organisation = Organisation.new(organisation_params)
    authorize @organisation
    @organisation.users << current_user

    respond_to do |format|
      if @organisation.save
        format.html { redirect_to organisation_url(@organisation), notice: "Organisation was successfully created." }
        format.json { render :show, status: :created, location: @organisation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @organisation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organisations/1 or /organisations/1.json
  def update
    authorize @organisation
    respond_to do |format|
      if @organisation.update(organisation_params)
        format.html { redirect_to organisation_url(@organisation), notice: "Organisation was successfully updated." }
        format.json { render :show, status: :ok, location: @organisation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @organisation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organisations/1 or /organisations/1.json
  def destroy
    authorize @organisation
    @organisation.destroy

    respond_to do |format|
      format.html { redirect_to organisations_url, notice: "Organisation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organisation
      @organisation = Organisation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def organisation_params
      params.require(:organisation).permit(:name)
    end
end
