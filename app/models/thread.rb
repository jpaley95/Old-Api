class Thread < ActiveRecord::Base
  ## Database Fields
  # t.string   "type",       null: false
  # t.integer  "user_id",    null: false
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false
  
  
  
  ## Relationships
  belongs_to :user
  has_many :messages
  has_and_belongs_to_many :participants, class_name: :Handle, join_table: :thread_participants
  
  
  
  ## Validation
  validates :user, presence: true
  validate :thread_must_have_at_least_one_participant
  
  
  
  ## Custom validation to ensure a participant exists
  def thread_must_have_at_least_one_participant
    if participants.size === 0
      errors.add(:participants, 'must have at least one element')
    end
  end
  
  
  
  ## Alias
  alias_attribute :author, :user
  
  
  
  ## Access Control
  # Checks if a thread can be read by a certain user
  # Note: Returns true iff the given user can write posts for at least one of
  #   the thread participant handles
  def can_be_read_by?(user, type_of_data = nil)
    participants.reduce(false) { |memo, participant| memo || user.can_write?(participant.specific, :posts) }
  end
  
  # Checks if a thread can be written by a certain user
  def can_be_written_by?(user, type_of_data = nil)
    can_be_read_by?(user, type_of_data)
  end
end
