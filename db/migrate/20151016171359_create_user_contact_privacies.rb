class CreateUserContactPrivacies < ActiveRecord::Migration
  def change
    create_table :user_contact_privacies do |t|
      # Many-to-many relationship between users and privacies
      t.belongs_to :user,    null: false
      t.belongs_to :privacy, null: false
      t.index [:user_id, :privacy_id], unique: true
      
      # Always include timestamps
      t.timestamps null: false
    end
  end
end
