class CreateMajors < ActiveRecord::Migration
  def change
    create_table :majors do |t|
      # Many-to-many relationship between users and fields
      t.belongs_to :user,  null: false
      t.belongs_to :field, null: false
      t.index [:user_id, :field_id], unique: true
      
      # Always include timestamps
      t.timestamps null: false
    end
  end
end
