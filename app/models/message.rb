class Message < ActiveRecord::Base
  ## Database Fields
  # t.integer  "user_id",    null: false
  # t.text     "content",    null: false
  # t.integer  "thread_id",  null: false
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false
  
  
  
  ## Relationships
  belongs_to :user
  belongs_to :thread
  
  has_and_belongs_to_many :files, join_table: :post_files
  
  
  
  ## Validation
  validates :user,    presence: true
  validates :thread,  presence: true
  validates :content, presence: true
  validate :user_is_participant_in_thread
  
  
  
  ## Custom validation
  def user_is_participant_in_thread
    unless user.can_write?(thread)
      errors.push(:user, 'is unauthorized to participate in the specified thread')
    end
  end
  
  
  
  ## Alias
  alias_attribute :attachments, :files
end
