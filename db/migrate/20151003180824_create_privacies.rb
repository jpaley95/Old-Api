class CreatePrivacies < ActiveRecord::Migration
  def change
    create_table :privacies do |t|
      ## Privacies: public, communities, connections, private
      
      # Text fields
      t.string :name, null: false
      t.index  :name, unique: true
      
      # Skip timestamps, since this is not a user-populated model
    end
  end
end
