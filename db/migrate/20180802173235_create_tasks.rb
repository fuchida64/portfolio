class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.text :title
      t.integer :status
      t.integer :task_group_id

      t.timestamps
    end
  end
end
