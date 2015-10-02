class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      # Text fields
      t.string :name, null: false
      t.index  :name, unique: true
      
      # Always include timestamps
      t.timestamps null: false
    end
  end
end
