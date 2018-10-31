class CreateDiaryComments < ActiveRecord::Migration[5.2]
  def change
  	create_table :diary_comments, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
  	# create_table :diary_comments do |t|
		t.text    :comment,  null: false
		t.integer :diary_id, null: false
		t.integer :user_id,  null: false

		t.timestamps
    end
  end
end
