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
  validate :participants_must_all_be_users_or_teams
  
  
  
  ## Custom validation to ensure a participant exists
  def thread_must_have_at_least_one_participant
    if participants.size === 0
      errors.add(:participants, 'must have at least one element')
    end
  end
  
  
  
  ## Custom validation to ensure all participants are users or teams
  def participants_must_all_be_users_or_teams
    unless participants.reduce(true) { |memo, participant| memo && ['User', 'Team'].include?(participant.type) }
      errors.add(:participants, 'currently may only be users or teams')
    end
  end
  
  
  
  ## Alias
  alias_attribute :author, :user
  
  
  
  ## Access Control
  # Checks if a thread can be accessed by a certain user
  def can_be_written_by?(user, type_of_data = nil)
    participants.reduce(false) { |memo, participant| memo || user.can_write?(participant.specific, :inbox) }
  end
end
