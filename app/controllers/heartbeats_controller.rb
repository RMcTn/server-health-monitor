class HeartbeatsController < ApplicationController
  require 'uri'
  require 'net/http'
  before_action :set_heartbeat, only: %i[ show edit update destroy ]
  before_action :set_server 
  before_action :set_organisation
  before_action :authenticate_user!

  # GET /heartbeats or /heartbeats.json
  def index
    authorize @organisation
    @heartbeats = @server.heartbeats
  end

  # GET /heartbeats/1 or /heartbeats/1.json
  def show
    authorize @organisation
  end

  # GET /heartbeats/new
  def new
    authorize @organisation
    @heartbeat = Heartbeat.new
  end

  # GET /heartbeats/1/edit
  def edit
    authorize @organisation
  end

  # POST /heartbeats or /heartbeats.json
  def create
    authorize @organisation
    @heartbeat = @server.heartbeats.create(status_code: res.code, request_time: Time.now)
    respond_to do |format|
      if @heartbeat.save
        format.html { redirect_to server_heartbeat_url(@server, @heartbeat), notice: "Heartbeat was successfully created." }
        format.json { render :show, status: :created, location: @heartbeat }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @heartbeat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /heartbeats/1 or /heartbeats/1.json
  def update
    authorize @organisation
    respond_to do |format|
      if @heartbeat.update(heartbeat_params)
        format.html { redirect_to heartbeat_url(@heartbeat), notice: "Heartbeat was successfully updated." }
        format.json { render :show, status: :ok, location: @heartbeat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @heartbeat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /heartbeats/1 or /heartbeats/1.json
  def destroy
    authorize @organisation
    @heartbeat.destroy

    respond_to do |format|
      format.html { redirect_to heartbeats_url, notice: "Heartbeat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_heartbeat
      @heartbeat = Heartbeat.find(params[:id])
    end

    def set_server
      @server = Server.find(params[:server_id])
    end

    def set_organisation
      @organisation = Organisation.find(params[:organisation_id])
    end

    # Only allow a list of trusted parameters through.
    def heartbeat_params
      params.require(:heartbeat).permit(:server_id)
    end
end
