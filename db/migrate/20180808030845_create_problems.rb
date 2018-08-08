class CreateProblems < ActiveRecord::Migration[5.2]
  def change
    create_table :problems do |t|
      t.text :problem_content
      t.integer :memory_id

      t.timestamps
    end
  end
end
