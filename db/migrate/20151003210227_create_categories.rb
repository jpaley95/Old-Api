class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      ## Text fields
      t.string :name, null: false
      t.index  :name, unique: true
      
      ## Include timestamps, even though this is initially not a user-created
      ##   category
      t.timestamps null: false
    end
  end
end
