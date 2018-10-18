class SystemNodesController < ApplicationController
  before_action :set_system_node, only: [:show, :edit, :update, :destroy]

  # GET /system_nodes
  # GET /system_nodes.json
  def index
    @system_nodes = SystemNode.all
  end

  # GET /system_nodes/1
  # GET /system_nodes/1.json
  def show
  end

  # GET /system_nodes/new
  def new
    @system_node = SystemNode.new
  end

  # GET /system_nodes/1/edit
  def edit
  end

  # POST /system_nodes
  # POST /system_nodes.json
  def create
    @system_node = SystemNode.new(system_node_params)

    respond_to do |format|
      if @system_node.save
        format.html { redirect_to @system_node, notice: 'System node was successfully created.' }
        format.json { render :show, status: :created, location: @system_node }
      else
        format.html { render :new }
        format.json { render json: @system_node.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /system_nodes/1
  # PATCH/PUT /system_nodes/1.json
  def update
    respond_to do |format|
      if @system_node.update(system_node_params)
        format.html { redirect_to @system_node, notice: 'System node was successfully updated.' }
        format.json { render :show, status: :ok, location: @system_node }
      else
        format.html { render :edit }
        format.json { render json: @system_node.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /system_nodes/1
  # DELETE /system_nodes/1.json
  def destroy
    @system_node.destroy
    respond_to do |format|
      format.html { redirect_to system_nodes_url, notice: 'System node was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system_node
      @system_node = SystemNode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def system_node_params
      params.require(:system_node).permit(:name, :address, :description)
    end

end
