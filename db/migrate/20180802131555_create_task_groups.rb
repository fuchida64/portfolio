class CreateTaskGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :task_groups, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.text :title
      t.text :content
      t.integer :position_id
      t.integer :user_id

      t.timestamps
    end
  end
end
