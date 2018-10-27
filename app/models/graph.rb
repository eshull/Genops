class Graph
  #a structure to represent the nodes and edges
  #for a particular graph/network view
  attr_accessor :attrs_to_show

  def initialize
    @nodes= {}
    @links = {}
    self.attrs_to_show = ['github','host']
  end


  def add_node(node, layers_of_sources = 1, layers_of_targets = 1)

    if layers_of_sources > 0
      self.add_edges(node.to_node_links)
      if layers_of_sources > 1
        node.sources.each do |s|
          self.add_node(s, layers_of_sources = layers_of_sources-1, layers_of_targets = 1)
        end
      end
    end

    if layers_of_targets > 0
      self.add_edges(node.from_node_links)

      if layers_of_targets > 1
        node.targets.each do |s|
          self.add_node(s, layers_of_sources= 1, layers_of_targets = layers_of_targets-1)
        end
      end
    end

  end

  def add_edges(edge_list)
    edge_list.each do |l|
      @links[l.id] = l
      @nodes[l.from_node_id] = l.from_node
      @nodes[l.to_node_id] = l.to_node
    end
  end

  def to_dot
    nodes_list = @nodes.map {|id,node| "node_#{id} [label=#{node.node_label(self.attrs_to_show)}] [URL=\"http://localhost:3001/system_nodes/#{id}/graph\"] " }

    edges_list = @links.map { |id,l| "node_#{l.from_node_id} -> node_#{l.to_node_id}" }

    "digraph {
        #{(nodes_list + edges_list).join(";\n")};
    }"
  end
end
