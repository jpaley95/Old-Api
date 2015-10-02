class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      # Many-to-many between users and roles
      t.belongs_to :user, null: false
      t.belongs_to :role, null: false
      t.index [:user_id, :role_id], unique: true
      
      # Always include timestamps
      t.timestamps null: false
    end
  end
end
