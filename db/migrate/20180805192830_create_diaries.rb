class CreateDiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :diaries, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|

      t.integer :user_id
      t.text :title
      t.text :content
      t.date :diary_date
      t.string :inform_status

      t.timestamps
    end
  end
end
