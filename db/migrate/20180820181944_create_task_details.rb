class CreateTaskDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :task_details, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
    # create_table :task_details do |t|
      t.date    :deadline
      t.integer :time_required
      t.integer :time_limit
      t.integer :task_id, null: false

      t.timestamps
    end
  end
end
