class CreateTasks < ActiveRecord::Migration[5.2]
  def change
  	create_table :tasks, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
  	# create_table :tasks do |t|
		t.text    :title,         null: false
		t.integer :status
		t.integer :position_id
		t.integer :task_group_id, null: false

		t.timestamps
    end
  end
end
