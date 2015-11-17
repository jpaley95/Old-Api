class Listing < ActiveRecord::Base
  ## Database Fields
  # t.integer  "handle_id",    null: false
  # t.integer  "user_id",      null: false
  # t.string   "title",        null: false
  # t.text     "description"
  # t.integer  "location_id"
  # t.integer  "positions"
  # t.integer  "category"
  # t.integer  "hours"
  # t.datetime "started_at"
  # t.datetime "finished_at"
  # t.datetime "closed_at"
  # t.integer  "salary_min"
  # t.integer  "salary_max"
  # t.integer  "salary_period"
  # t.integer  "equity_min"
  # t.integer  "equity_max"
  # t.integer  "privacy_id",   null: false
  # t.datetime "created_at",   null: false
  # t.datetime "updated_at",   null: false
  
  
  
  ## Relationships
  belongs_to :user
  belongs_to :handle
  belongs_to :privacy
  belongs_to :location
  has_many :members, class_name: :ListingMember
  has_and_belongs_to_many :skills, class_name: :Tag, join_table: :listing_skills
  
  
  
  ## Validation
  validates :user,    presence: true
  validates :title,   presence: true
  validates :handle,  presence: true
  validates :privacy, presence: true
  
  
  
  ## Alias
  alias_attribute :owner,    :handle
  alias_attribute :deadline, :closed_at
  
  
  
  ## Enumerations
  enum category: [
    :internship,
    :freelance,
    :employment,
    :cofounder
  ]
  enum hours: [
    :full_time,
    :part_time
  ]
  enum salary_period: [
    :hour,
    :week,
    :month,
    :year
  ]
  
  
  
  ## Intercept the privacy setter to call the Privacy factory method
  def privacy=(string)
    super(Privacy.construct(string).first)
  end
  
  
  
  ## Intercept the skills setter to call the Tag factory method
  def skills=(skills)
    super(Tag.construct skills)
  end
  
  
  
  ## Provide a method to set the attributes of the location association
  def location=(data)
    if self.location.present? && !data.is_a?(Hash)
      self.location.destroy
    end
    
    if data.is_a?(Hash)
      if self.location.present?
        self.location.attributes = data
      else
        super(Location.new data)
      end
    else
      super(data)
    end
  end
  
  
  
  ## Access Control
  # Checks if a team can be read by a certain user
  def can_be_read_by?(user, type_of_data)
    case privacy.name
    when 'public'
      true
    when 'communities'
      self.user.neighbors.include?(user)
    when 'connections'
      self.user.connections.include?(user)
    when 'teams'
      self.user.teammates.include?(user)
    else
      false
    end
end
