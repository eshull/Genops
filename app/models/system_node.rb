class SystemNode < ApplicationRecord
  has_many :configurations

  has_many :from_node_links, :foreign_key => :from_node_id,
          :class_name => 'SystemLink'
  has_many :targets, :through => :from_node_links,
          :source => :to_node

  has_many :to_node_links, :foreign_key => :to_node_id,
           :class_name => 'SystemLink'
  has_many :sources, :through => :to_node_links,
           :source => :from_node


  def dot
    nodes = {}

    self.sources.each do |n|
      nodes[n.id] = n
    end

    self.targets.each do |n|
      nodes[n.id]=n
    end

    nodes_list = nodes.map {|id,node| "node_#{id} [label=\"#{node.name}\"]"}

    edges_list = self.sources.map { |n| "node_#{n.id} -> node_#{self.id}" }
    edges_list += self.targets.map { |n| "node_#{self.id} -> node_#{n.id}" }


    "digraph {
        #{(nodes_list + edges_list).join(";\n")};
    }"
  end

  def simpler_dot
    'digraph {
        Node1;
        Node2;
        Node3;
        Node4 [shape=cylinder];
        Node1 -> Node2;
        Node1 -> Node3;
        Node2 -> Node3;
        Node3 -> Node4;
    }'
  end
  def sample_dot
    'digraph {
        graph [label="Click on a node or an edge to delete it" labelloc="t", fontsize="20.0" tooltip=" "]
        node [style="filled"]
        Node1 [id="NodeId1" label="N1" fillcolor="#d62728"]
        Node2 [id="NodeId2" label="N2" fillcolor="#1f77b4"]
        Node3 [id="NodeId3" label="N3" fillcolor="#2ca02c"]
        Node4 [id="NodeId4" label="N4" fillcolor="#ff7f0e"]
        Node1 -> Node2 [id="EdgeId12" label="E12"]
        Node1 -> Node3 [id="EdgeId131" label="E13"]
        Node2 -> Node3 [id="EdgeId23" label="E23"]
        Node3 -> Node4 [id="EdgeId34" label="E34"]
    }'
  end
  # def links
  #   (from_node_links + to_node_links).flatten.uniq
  # end
  def hello
    "hello"
  end
  # Call @system_node.links to see all the associated links
end
