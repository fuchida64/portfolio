class CreateMemoryStages < ActiveRecord::Migration[5.2]
  def change
    create_table :memory_stages do |t|
      t.integer :stage, null: false
      t.integer :period, null: false
      t.integer :memory_group_id, null: false

      t.timestamps
    end
  end
end
