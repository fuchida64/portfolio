class CreateMemoryGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :memory_groups do |t|
      t.text :title
      t.text :content
      t.integer :user_id

      t.timestamps
    end
  end
end
