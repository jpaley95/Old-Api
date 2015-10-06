class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      ## Team Permissions: leaders, members, interns, freelancers, mentors
      ##
      ## Community Permissions: owners, administrators, members
      
      # Text fields
      t.string :name, null: false
      t.index  :name, unique: true
      
      # Skip timestamps, since this is not a user-populated model
    end
  end
end
