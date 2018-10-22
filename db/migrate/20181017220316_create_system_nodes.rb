class CreateSystemNodes < ActiveRecord::Migration[5.2]
  def change
    create_table :system_nodes do |t|
      t.string :name
      t.string :address
      t.string :description
      t.text :status_check_how_to
      t.text :status_check_script

      t.timestamps
    end
  end
end
