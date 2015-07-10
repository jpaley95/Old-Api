class CreateProblemPromoters < ActiveRecord::Migration
  def change
    create_table :problem_promoters do |t|
      # Many-to-many relationship between users and problems
      t.belongs_to :promoter, null: false
      t.belongs_to :promoted, null: false
      t.index [:promoter_id, :promoted_id], unique: true
      
      # Always include timestamps
      t.timestamps
    end
  end
end
