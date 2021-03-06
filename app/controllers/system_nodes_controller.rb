class SystemNodesController < ApplicationController
  before_action :set_system_node, only: [:show, :edit, :update, :destroy]

  def index
    if params["type"]
      @system_nodes = SystemNode.query_by_type(params["type"])
    else
      @system_nodes = SystemNode.all
    end
  end

  def show
    @system_node = SystemNode.find(params[:id])
  end

  def new
    @system_node = SystemNode.new
  end

  def edit
    @system_node = SystemNode.find(params[:id])
    @source = SystemLink.where(from_node_id: @system_node.id)
    @target = SystemLink.where(to_node_id: @system_node.id)
  end

  def create
    @system_node = SystemNode.new(system_node_params)

    respond_to do |format|
      if @system_node.save
        format.html { redirect_to edit_system_node_path(@system_node), notice: 'System node was successfully created.' }
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
        format.html { redirect_to edit_system_node_path(@system_node), notice: 'System node was successfully updated.' }
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

  def add_target()
    source_id = request.params['id']
    l = SystemLink.create(from_node_id: source_id, to_node_id: request.params['target_node_id'])
    redirect_to action: "edit", id: source_id
  end

  def add_source()
    target_id = request.params['id']
    l = SystemLink.create(to_node_id: target_id, from_node_id: request.params['source_node_id'])
    redirect_to action: "edit", id: target_id
  end

  def graph
    @system_node = SystemNode.find(params[:id])
    @system_nodes = SystemNode.all
  end

  def d3
    @system_node = SystemNode.find(params[:id])
    @system_nodes = SystemNode.all
  end

  def status
    @System_node = SystemNode.where(:id => params[:find_id])
     respond_to do |format|
         format.js
     end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system_node
      @system_node = SystemNode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def system_node_params
      params.require(:system_node).permit(:name, :address, :description, :from_node_ids, :to_node_ids )
    end

    def update_params
      params.require(:system_node).permit(:from_node_ids => [],:to_node_ids => [])
    end

end
