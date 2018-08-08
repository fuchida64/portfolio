class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.text :answer_content
      t.integer :memory_id

      t.timestamps
    end
  end
end
