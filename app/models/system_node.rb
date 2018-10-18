class SystemNode < ApplicationRecord
  has_many :configurations
  has_many :system_nodes, through: :system_links
end
