class SystemNode < ApplicationRecord
  has_many :settings

  has_many :from_node_links, :foreign_key => :from_node_id,
          :class_name => 'SystemLink'
  has_many :targets, :through => :from_node_links,
          :source => :to_node

  has_many :to_node_links, :foreign_key => :to_node_id,
           :class_name => 'SystemLink'
  has_many :sources, :through => :to_node_links,
           :source => :from_node


  def dot2
    g = Graph.new
    g.add_node(self, 2, 2)
    g.to_dot
  end
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

  def method_missing(m, *args, &block)
    for s in self.settings
      return s.value if s.key==m.to_s
    end
    puts "There is no method #{m}"
    return nil
  end


  def node_settings
    '<% @system_nodes.each do |system_node| %>
      <div class="col-md-4">
        <h2><%= system_node.name %></h2>  </br>
        <%= system_node.address %> </br>
        <%= system_node.description %> </br>
        settings: <%= system_node.settings.count %> </br>
        sources: <%= system_node.sources.count %> </br>
        targets: <%= system_node.targets.count %> </br>
        <%= link_to "Show", system_node %>
        <%= link_to "Edit", edit_system_node_path(system_node) %>
        <%= link_to "Destroy", system_node, method: :delete, data: { confirm: "Are you sure?" } %>
        <div class="node-settings">
          <table class="table">
           <tr>
             <th>Key:</th>
             <th>Value:</th>
           </tr>
          <% system_node.settings.each do |setting| %>
               <tr>
                 <td>Key: <%= setting.key %></td>
                 <td>Value: <%= setting.value %></td>
               </tr>
            <% end %>
          </table>
        </div>
      </div>

    <% end %>'

  end
end
