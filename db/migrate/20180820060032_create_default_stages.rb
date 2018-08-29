class CreateDefaultStages < ActiveRecord::Migration[5.2]
  def change
    create_table :default_stages do |t|
      t.integer :stage, null: false
      t.integer :period, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
