class Message < ActiveRecord::Base
  ## Database Fields
  # t.integer  "handle_id",  null: false
  # t.integer  "user_id",    null: false
  # t.text     "content",    null: false
  # t.integer  "thread_id",  null: false
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false
  
  
  
  ## Relationships
  belongs_to :user
  belongs_to :handle
  belongs_to :thread
  has_many :files, as: :owner
  
  
  
  ## Validation
  validates :user,    presence: true
  validates :handle,  presence: true
  validates :thread,  presence: true
  validates :content, presence: true
  validate :handle_is_participant_in_thread
  
  
  
  ## Custom validation
  def handle_is_participant_in_thread
    unless thread.participants.include?(handle)
      errors.push(:handle, 'must be a participant in the specified thread')
    end
  end
  
  
  
  ## Alias
  alias_attribute :author,      :handle
  alias_attribute :attachments, :files
  
  
  
  ## Access Control
  # Checks if a message can be read by a certain user
  def can_be_read_by?(user, type_of_data = nil)
    user.can_read?(thread)
  end
  
  # Checks if a message can be written by a certain user
  def can_be_written_by?(user, type_of_data = nil)
    user.can_write?(handle.specific, :posts)
  end
end
