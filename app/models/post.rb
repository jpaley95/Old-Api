class Post < ActiveRecord::Base
  ## Database Fields
  # t.integer  "handle_id",  null: false
  # t.integer  "user_id",    null: false
  # t.text     "content",    null: false
  # t.integer  "privacy_id", null: false
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false
  
  
  
  ## Relationships
  belongs_to :handle
  belongs_to :user
  belongs_to :privacy
  has_many :files, class_name: :Image, as: :owner, -> { where owner_association: :files }
  
  
  
  ## Validation
  validates :user,    presence: true
  validates :handle,  presence: true
  validates :privacy, presence: true
  validates :content, presence: true
  
  
  
  ## Alias
  alias_attribute :posted_at,   :created_at
  alias_attribute :message,     :content
  alias_attribute :author,      :handle
  alias_attribute :attachments, :files
  
  
  
  ## Intercept the privacy setter to call the Privacy factory method
  def privacy=(string)
    super(Privacy.construct(string).first)
  end
  
  
  
  ## Access Control
  # Checks if a post can be read by a certain user
  def can_be_read_by?(user)
    case privacy.name
    when 'public'
      true
    when 'connections'
      self.user.connections.include?(user)
    when 'communities'
      self.user.neighbors.include?(user)
    when 'teams'
      self.user.teammates.include?(user)
    else
      false
    end
  end
  
  # Checks if a post can be written by a certain user
  def can_be_written_by?(user)
    case handle.specific.class.name.demodulize
    when 'User'
      user === handle.specific
    when 'Team', 'Community'
      user.can_write?(handle.specific, :posts)
    else
      false
    end
  end
end