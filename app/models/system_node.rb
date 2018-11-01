class SystemNode < ApplicationRecord
  has_many :settings

  has_many :target_links, :foreign_key => :from_node_id,
          :class_name => 'SystemLink'
  has_many :targets, :through => :target_links,
          :source => :to_node, dependent: :destroy

  has_many :source_links, :foreign_key => :to_node_id,
           :class_name => 'SystemLink'
  has_many :sources, :through => :source_links,
           :source => :from_node, dependent: :destroy

  def get_setting(key)
    for setting in self.settings
      return setting.value if setting.key==key
    end
    return nil
  end

  def dot2(attrs_to_show=['github','host'])
    g = Graph.new
    g.attrs_to_show = attrs_to_show
    g.add_node(self, 4, 4)
    g.to_dot
  end

  def node_label(attr_names)
    #this will make an html label in dot syntax
    #with the node name on the first line and a row for
    #any of the provided attr_names if and only if that node has a value
    #for that parameter
    node_label = "<#{self.name}<br/>"

    attr_names.each {|k|
      v = self.get_setting(k)
      if v
        node_label+="#{k}: #{v}"
      end
    }
    node_label+=">"
  end

  # attrs_to_show is hard coded or default? here in the params
  def dot(attrs_to_show=['github','host'])
    return dot2(attrs_to_show=['github','host'])

    # creation of initial self node
    nodes = {self.id=>self}
    # creation of nodes from sources
    self.sources.each do |n|
      nodes[n.id] = n
    end
    # creation of nodes from targets
    self.targets.each do |n|
      nodes[n.id]=n
    end

  # creation of dot language nodes list from nodes
    nodes_list = nodes.map {|id,node|
      # output example: "node_19 [label=<Reporter<br/>>]"
      "node_#{id} [label=#{node.node_label(attrs_to_show)} fillcolor=\"#d62728\"]"
    }
    # creation of edges list in dot notation
    edges_list = self.sources.map { |n| "node_#{n.id} -> node_#{self.id}" }
    edges_list += self.targets.map { |n| "node_#{self.id} -> node_#{n.id} " }


    "digraph {
        #{(nodes_list + edges_list).join(";\n")};
    }"
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

  def hello
    "hello"
  end

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

  def self.query_by_type(type_name)
    SystemNode.joins(:settings).where("settings.key='type:#{type_name}'")
  end

  def self.import_yaml(yaml_path)

    data = YAML.load_file(yaml_path)

    nodes = data["nodes"]

    puts "File has #{nodes.count} nodes"

    # nodes.each { |k, v| puts "Node name: ${k}\n\t properties: #{v}" }
    nodes.each { |k, v| puts "The hash key is #{k} and the value is #{v}."}
    nodes.each do |nodekey, nodevalue|
      puts "The hash key is #{nodekey} and the value is #{nodevalue}."
      node = SystemNode.find_or_create_by(name: nodekey.to_s)

      nodevalue.each do |settingkey, settingvalue|
        if settingkey != 'targets' && settingkey != "sources"
          #node = SystemNode.find_or_create_by(name: nodekey.to_s)
          setting = node.settings.find_or_create_by(key: settingkey)
          if setting.value && setting.value != settingvalue
            puts "Changing node #{node.id} #{settingkey} from #{setting.value} to #{settingvalue}"
          end
          if setting.value != settingvalue
            setting.value = settingvalue
            setting.save!
          end
          puts "The setting key for #{nodekey} is #{settingkey} and the setting value is #{settingvalue}."
        else
          #dealing with targets
          if settingvalue.class == Array
            #at this point settingvalue is the array of Hashes of target node
            settingvalue.each do |linked_node_hash|
              #given our convention in the yaml file,
              #each key of linked_node_hash will be a node name
              #of the target, and the value of the hash will be a hash of any
              # key value pairs listed under the target node name in the yaml
              puts "unexpected format" if linked_node_hash.count>1

              linked_node_name = linked_node_hash.keys[0]

              linked_node = SystemNode.find_or_create_by(name: linked_node_name)

              if settingkey == "targets"
                link_types = node.target_links
                from_node_id = node.id
                to_node_id = linked_node.id
              else
                link_types = node.source_links
                from_node_id = linked_node.id
                to_node_id = node.id
              end
              link_types.find_or_create_by(from_node_id: from_node_id, to_node_id: to_node_id)
            end
          else
            puts "warning, targets for #{node.name} was not an array, skipping"
          end
        end
      end
    end
  end
end
