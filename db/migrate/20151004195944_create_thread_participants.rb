class CreateThreadParticipants < ActiveRecord::Migration
  def change
    create_table :thread_participants do |t|
      # Many-to-many between handles and threads
      t.belongs_to :handle, null: false
      t.belongs_to :thread, null: false
      t.index [:handle_id, :thread_id], unique: true
      
      # Always include timestamps
      t.timestamps null: false
    end
  end
end
