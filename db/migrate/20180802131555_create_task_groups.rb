class CreateTaskGroups < ActiveRecord::Migration[5.2]
  def change
  	create_table :task_groups, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
  	# create_table :task_groups do |t|
		t.text    :title,      null: false
		t.text    :content
		t.integer :position_id
		t.integer :user_id,    null: false

		t.timestamps
    end
  end
end
