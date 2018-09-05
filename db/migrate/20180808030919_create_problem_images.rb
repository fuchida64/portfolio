class CreateProblemImages < ActiveRecord::Migration[5.2]
  def change
    create_table :problem_images do |t|
      t.string :problem_image_id
      t.integer :memory_id, null: false

      t.timestamps
    end
  end
end
