class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.text :title
      t.integer :status
      t.integer :position_id
      t.integer :task_group_id

      t.timestamps
    end
  end
end
