class PrivateThread < Thread
  ## Database Fields
  # t.string   "type",       null: false
  # t.integer  "user_id",    null: false
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false
  
  
  
  ## Validation
  validate :thread_must_have_two_participants
  
  
  
  ## Custom validation to ensure a participant exists
  def thread_must_have_two_participants
    if participants.size != 2
      errors.add(:participants, 'must have two elements')
    end
  end
end
