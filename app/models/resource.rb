class Resource < ActiveRecord::Base
  ## Database Fields
  # t.string   "name",         null: false
  # t.text     "overview"
  # t.string   "website"
  # t.string   "facebook"
  # t.string   "twitter"
  # t.integer  "privacy_id",   null: false
  # t.integer  "community_id", null: false
  # t.integer  "location_id"
  # t.datetime "created_at",   null: false
  # t.datetime "updated_at",   null: false
  
  
  
  ## Actable (MTI)
  acts_as :handle
  
  
  
  ## Relationships
  belongs_to :community
  belongs_to :privacy
  belongs_to :location
  
  has_and_belongs_to_many :tags,       join_table: :resource_tags
  has_and_belongs_to_many :categories, join_table: :resource_categories
  
  has_one :avatar, class_name: :Image, as: :owner
  
  
  
  ## Validation
  validates :name,      presence: true
  validates :privacy,   presence: true
  validates :community, presence: true
  
  
  
  ## Intercept the privacy setter to call the Privacy factory method
  def privacy=(string)
    super(Privacy.construct(string).first)
  end
  
  
  
  ## Intercept the categories setter to call the Category factory method
  def categories=(categories)
    super(Category.construct categories)
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
  # Checks if a resource can be read by a certain user
  def can_be_read_by?(user)
    privacy.name === 'public' || user.role_in(community) !== 'none'
  end
end