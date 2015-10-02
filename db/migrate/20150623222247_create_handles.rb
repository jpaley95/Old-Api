class CreateHandles < ActiveRecord::Migration
  def change
    create_table :handles do |t|
      # Username
      t.string :username, null: false
      t.index  :username, unique: true
      
      # Multiple Table Inheritance (MTI)
      t.actable null: false
      t.index [:actable_id, :actable_type], unique: true
      
      # Always include timestamps
      t.timestamps null: false
    end
  end
end
