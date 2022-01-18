class ServersController < ApplicationController
  before_action :set_server, only: %i[ show edit update destroy ]
  before_action :set_organisation, only: %i[ show new create edit update destroy ]
  before_action :authenticate_user!

  # GET /servers or /servers.json
  def index
    @servers = Server.all
  end

  # GET /servers/1 or /servers/1.json
  def show
  end

  # GET /servers/new
  def new
    @server = Server.new
  end

  # GET /servers/1/edit
  def edit
  end

  # POST /servers or /servers.json
  def create
    @server = @organisation.servers.create(server_params)

    respond_to do |format|
      if @server.save
        format.html { redirect_to organisation_server_url(@organisation, @server), notice: "Server was successfully created." }
        format.json { render :show, status: :created, location: @server }
        SendHeartbeatJob.perform_later(@server)
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /servers/1 or /servers/1.json
  def update
    # TODO: Requeue job if updated?
    respond_to do |format|
      if @server.update(server_params)
        format.html { redirect_to organisation_server_url(@organisation, @server), notice: "Server was successfully updated." }
        format.json { render :show, status: :ok, location: @server }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /servers/1 or /servers/1.json
  def destroy
    @server.destroy

    respond_to do |format|
      format.html { redirect_to organisation_url(@organisation), notice: "Server was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_server
      @server = Server.find(params[:id])
    end

    def set_organisation
      @organisation = Organisation.find(params[:organisation_id])
    end

    # Only allow a list of trusted parameters through.
    def server_params
      params.require(:server).permit(:hostname)
    end
end
