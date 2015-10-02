class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      # Description (Optional)
      t.string :description
      
      # Address
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      
      # Geolocation
      t.decimal :latitude
      t.decimal :longitude
      t.index   [:latitude, :longitude]
      
      # Always include timestamps
      t.timestamps null: false
    end
  end
end
