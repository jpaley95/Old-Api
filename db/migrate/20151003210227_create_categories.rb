class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      ## Personal information
      t.string :name, null: false
      t.text :description
      
      # Skip timestamps, since this is not a user-populated model
    end
  end
end
