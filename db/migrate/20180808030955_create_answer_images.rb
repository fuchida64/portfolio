class CreateAnswerImages < ActiveRecord::Migration[5.2]
  def change
    create_table :answer_images do |t|
      t.string :answer_image_id
      t.integer :memory_id

      t.timestamps
    end
  end
end
