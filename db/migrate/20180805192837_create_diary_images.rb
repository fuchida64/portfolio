class CreateDiaryImages < ActiveRecord::Migration[5.2]
  def change
  	create_table :diary_images, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
		t.string  :diary_image_id, null: false
		t.integer :diary_id,       null: false

		t.timestamps
    end
  end
end
