class CreateDiaryImages < ActiveRecord::Migration[5.2]
  def change
    create_table :diary_images do |t|
      t.integer :diary_id, null: false
      t.string :diary_image_id, null: false

      t.timestamps
    end
  end
end
