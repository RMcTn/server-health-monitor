class HeartbeatsController < ApplicationController
  require 'uri'
  require 'net/http'
  before_action :set_heartbeat, only: %i[ show edit update destroy ]
  before_action :set_server 

  # GET /heartbeats or /heartbeats.json
  def index
    @heartbeats = Heartbeat.all
  end

  # GET /heartbeats/1 or /heartbeats/1.json
  def show
  end

  # GET /heartbeats/new
  def new
    @heartbeat = Heartbeat.new
  end

  # GET /heartbeats/1/edit
  def edit
  end

  # POST /heartbeats or /heartbeats.json
  def create
    p "IN CREATE"

    uri = URI.parse(@server.hostname)
    p uri
    p "Sending request to " + uri.to_s
    res = Net::HTTP.get_response(uri)
    p "SUCCESS" if res.is_a?(Net::HTTPSuccess)

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

    # Only allow a list of trusted parameters through.
    def heartbeat_params
      params.require(:heartbeat).permit(:server_id)
    end
end
