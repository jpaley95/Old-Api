class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      ## User Roles:      entrepreneur, freelancer, instructor, mentor
      ##
      ## Community Roles: owner, administrator, member
      ##
      ## Team Roles:      founder, leader, teammate, freelancer, intern,
      ##                  board, investor, mentor
      
      # Text fields
      t.string :name, null: false
      t.index  :name, unique: true
      
      # Skip timestamps, since this is not a user-populated model
    end
  end
end
