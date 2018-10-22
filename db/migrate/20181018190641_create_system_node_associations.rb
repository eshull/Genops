class CreateSystemNodeAssociations < ActiveRecord::Migration[5.2]
  def change
    create_table :system_links do |t|
      t.integer :from_node_id
      t.integer :to_node_id

      t.timestamps
    end
  end
end
