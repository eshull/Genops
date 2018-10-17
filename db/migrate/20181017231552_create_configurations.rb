class CreateConfigurations < ActiveRecord::Migration[5.2]
  def change
    create_table :configurations do |t|
      t.text :key
      t.text :value
      t.text :location
      t.belongs_to :system_node, index: true
      t.timestamps
    end
  end
end
