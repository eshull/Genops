class SystemLink < ApplicationRecord
  #belongs_to :system_node

  belongs_to :from_node, :class_name => 'SystemNode', :foreign_key => 'from_node_id'
  belongs_to :to_node, :class_name => 'SystemNode', :foreign_key => 'to_node_id'
end
