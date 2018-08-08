class CreateMemories < ActiveRecord::Migration[5.2]
  def change
    create_table :memories do |t|
      t.integer :stage
      t.date :execution_date
      t.integer :memory_group_id

      t.timestamps
    end
  end
end
