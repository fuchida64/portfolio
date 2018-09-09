class CreateMemoryStages < ActiveRecord::Migration[5.2]
  def change
    create_table :memory_stages, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.integer :stage
      t.integer :period
      t.integer :memory_group_id

      t.timestamps
    end
  end
end
