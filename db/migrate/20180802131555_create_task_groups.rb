class CreateTaskGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :task_groups do |t|
      t.text :title
      t.text :contents
      t.integer :user_id

      t.timestamps
    end
  end
end
