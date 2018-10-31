class CreateMemories < ActiveRecord::Migration[5.2]
  def change
    create_table :memories, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
    # create_table :memories do |t|
      t.text    :problem_content
      t.string  :problem_image_id
      t.text    :answer_content
      t.string  :answer_image_id
      t.integer :stage,           default: 1
      t.integer :correct_num,     default: 0
      t.integer :wrong_num,       default: 0
      t.date    :execution_date
      t.date    :perform_date
      t.integer :memory_group_id, null: false

      t.timestamps
    end
  end
end
