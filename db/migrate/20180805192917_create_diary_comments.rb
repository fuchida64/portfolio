class CreateDiaryComments < ActiveRecord::Migration[5.2]
  def change
    create_table :diary_comments, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.integer :user_id
      t.integer :diary_id
      t.text :comment

      t.timestamps
    end
  end
end
