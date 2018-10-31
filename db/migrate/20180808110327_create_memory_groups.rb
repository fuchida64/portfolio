class CreateMemoryGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :memory_groups, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
    # create_table :memory_groups do |t|
      t.text    :title,       null: false
      t.text    :content
      t.integer :position_id
      t.integer :loop,        default: 0
      t.integer :period,      default: 1
      t.integer :untie,       default: 1
      t.integer :user_id,     null: false

      t.timestamps
    end
  end
end
