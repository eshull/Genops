class SystemNode < ApplicationRecord
  has_many :configurations

  has_many :from_node_links, :foreign_key => :from_node_id,
          :class_name => 'SystemLink'
  has_many :from_nodes, :through => :from_node_links,
          :source => :to_node

  has_many :to_node_links, :foreign_key => :to_node_id,
           :class_name => 'SystemLink'
  has_many :to_nodes, :through => :to_node_links,
           :source => :from_node

  def links
    (from_node_links + to_node_links).flatten.uniq
  end
  # Call @system_node.links to see all the associated links
end
