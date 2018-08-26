class CreateDiaryComments < ActiveRecord::Migration[5.2]
  def change
    create_table :diary_comments do |t|
      t.integer :user_id, null: false
      t.integer :diary_id, null: false
      t.text :comment, null: false

      t.timestamps
    end
  end
end
