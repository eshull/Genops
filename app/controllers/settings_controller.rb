class SettingsController < ApplicationController
  before_action :set_setting, only: [:show, :edit, :update, :destroy]

  ActionController::Parameters.permit_all_parameters = true

  # GET /settings
  # GET /settings.json
  def index
    @system_node = SystemNode.find(params[:system_node_id])
    @settings = @system_node.settings
  end

  # GET /settings/1
  # GET /settings/1.json
  def show
  end

  # GET /settings/new
  def new
    @system_node = SystemNode.find(params[:system_node_id])
    @setting = @system_node.settings.new(setting_params)
    @system_nodes = SystemNode.all
    # @setting = Setting.new
  end

  # GET /settings/1/edit
  def edit
    @system_node = SystemNode.find(params[:system_node_id])
    @setting = Setting.find(params[:id])

    # system_node = SystemNode.find(params[:id])
    # @setting = Setting.find(params[system_node.id])
  end

  # POST /settings
  # POST /settings.json
  def create
    @system_node = SystemNode.find(params[:system_node_id])
    @setting = @system_node.settings.new()
#binding.pry
    @setting.key = params[:setting][:key]
    @setting.value = params[:setting][:value]
    @setting.location = params[:setting][:location]


    respond_to do |format|
      if @setting.save
        format.html { redirect_to edit_system_node_path(@system_node), notice: 'Setting was successfully created.' }
        format.json { render :show, status: :created, location: @setting }
      else
        format.html { render :new }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /settings/1
  # PATCH/PUT /settings/1.json
  def update

    respond_to do |format|

      key = params["setting"]["key"]
      value = params["setting"]["value"]
      @setting.key = key
      @setting.value = value
      @setting.location = params["setting"]["location"]
      if @setting.save!

        format.html { redirect_to edit_system_node_path(@setting.system_node_id), notice: 'Setting was successfully updated.' }
        format.json { render :show, status: :ok, location: @setting }
      else
        format.html { render :edit }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /settings/1
  # DELETE /settings/1.json
  def destroy
    system_node_id = @setting.system_node_id
    @setting.destroy
    respond_to do |format|
      format.html { redirect_to edit_system_node_path(system_node_id), notice: 'Setting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_setting
      @setting = Setting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def setting_params
        params.permit(:setting, :key, :value, :location) #, :key, :value, :location, #:system_node_id )
    end
end
