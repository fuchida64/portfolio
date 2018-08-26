class CreateDiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :diaries do |t|

      t.integer :user_id, null: false
      t.text :title, null: false, :index => true
      t.text :content, null: false, :index => true
      t.date :diary_date, null: false
      t.string :inform_status, null: false

      t.timestamps
    end
  end
end
