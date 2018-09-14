class CreateDiaries < ActiveRecord::Migration[5.2]
  def change
    # create_table :diaries, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
    create_table :diaries do |t|
      t.text    :title,         null: false
      t.text    :content
      t.date    :diary_date
      t.string  :inform_status, null: false
      t.integer :user_id,       null: false

      t.timestamps
    end
  end
end
