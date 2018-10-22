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
    @system_node = SystemNode.find(params[:id])
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

  def add_target()
    puts "hello are you here "
    #source_node = SystemNode.find(request.params['id'])
    #target_node = SystemNode.find(request.params['target_node_id'])
    #source_node.targets.add(target_node)
     source_id = request.params['id']
     l = SystemLink.create(from_node_id: source_id, to_node_id: request.params['target_node_id'])


    #render "/system_nodes/#{source_id}/edit"
    redirect_to action: "edit", id: source_id
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
