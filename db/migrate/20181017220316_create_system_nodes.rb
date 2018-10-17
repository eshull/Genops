class CreateSystemNodes < ActiveRecord::Migration[5.2]
  def change
    create_table :system_nodes do |t|

      t.timestamps
    end
  end
end
