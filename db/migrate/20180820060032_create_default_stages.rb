class CreateDefaultStages < ActiveRecord::Migration[5.2]
  def change
    create_table :default_stages, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.integer :stage
      t.integer :period
      t.integer :user_id

      t.timestamps
    end
  end
end
