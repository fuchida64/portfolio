class CreateMemoryStages < ActiveRecord::Migration[5.2]
  def change
    create_table :memory_stages do |t|
      t.integer :stage
      t.integer :period
      t.integer :user_id

      t.timestamps
    end
  end
end
