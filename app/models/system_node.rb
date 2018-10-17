class SystemNode < ApplicationRecord
  has_many :configurations

  has_many :receive_nodes, class_name: "SystemNode", foreign_key: "send_node_id"
  belongs_to :send_node, class_name: "SystemNode"
  has_many :send_nodes, class_name: "SystemNode", foreign_key: "receive_node_id"
  belongs_to :receive_node, class_name: "SystemNode"
end
