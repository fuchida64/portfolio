class CreateDiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :diaries do |t|
      t.integer :user_id
      t.text :title
      t.text :content
      t.string :inform_status

      t.timestamps
    end
  end
end
