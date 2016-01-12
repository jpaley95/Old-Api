class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      # Personal information
      t.string  :first_name
      t.string  :last_name
      t.date    :birthday
      t.integer :gender
      
      # Biographical information
      t.text :biography
      t.text :goals
      t.text :awards
      
      # Status information
      t.string  :headline
      t.string  :ask_about
      t.integer :focus
      
      # Social information
      t.string :website
      t.string :facebook
      t.string :twitter
      t.string :linkedin
      t.string :github
      
      # Flags
      t.boolean :is_superuser, null: false, default: false
      
      # Location
      t.belongs_to :location, index: true
      
      # Avatar
      t.belongs_to :avatar, index: true
      
      
      
      
      ## Database Authenticatable
      t.string :email,              null: false
      t.index  :email,              unique: true
      t.string :encrypted_password, null: false
      
      ## Recoverable
      t.string   :reset_password_token
      t.index    :reset_password_token,   unique: true
      t.datetime :reset_password_sent_at
      
      ## Rememberable
      # t.datetime :remember_created_at
      
      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      
      ## Encryptable
      # t.string :password_salt
      
      ## Confirmable
      t.string   :confirmation_token
      t.index    :confirmation_token,   unique: true
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email                        # Only if using reconfirmable
      
      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token                             # Only if unlock strategy is :email or :both
      t.index    :unlock_token, unique: true
      t.datetime :locked_at
      
      # Token authenticatable
      t.string :authentication_token

      ## Invitable
      # t.string :invitation_token
      
      
      
      
      # Always include timestamps
      t.timestamps null: false
    end
  end
end
