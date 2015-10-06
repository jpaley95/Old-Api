class CreateResourceCategories < ActiveRecord::Migration
  def change
    create_table :resource_categories do |t|
      # Many-to-many between resources and categories
      t.belongs_to :resource, null: false
      t.belongs_to :category, null: false
      t.index [:resource_id, :category_id], unique: true
      
      # Always include timestamps
      t.timestamps null: false
    end
  end
end
