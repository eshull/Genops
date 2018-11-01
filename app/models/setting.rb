class Setting < ApplicationRecord
  belongs_to :system_node
  validates :key, uniqueness: {scope: :system_node_id}
end
