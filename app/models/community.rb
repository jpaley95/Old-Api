class Community < ActiveRecord::Base
  ## Database Fields
  # t.string   "name",                            null: false
  # t.string   "headline"
  # t.string   "video"
  # t.string   "domains"
  # t.text     "policy"
  # t.text     "description"
  # t.string   "website"
  # t.string   "facebook"
  # t.string   "twitter"
  # t.string   "linkedin"
  # t.string   "avatar_file_name"
  # t.string   "avatar_content_type"
  # t.integer  "avatar_file_size"
  # t.datetime "avatar_updated_at"
  # t.string   "logo_file_name"
  # t.string   "logo_content_type"
  # t.integer  "logo_file_size"
  # t.datetime "logo_updated_at"
  # t.date     "founded_at"
  # t.datetime "archived_at"
  # t.integer  "category",                        null: false
  # t.integer  "manage_profile",      default: 0, null: false
  # t.integer  "manage_members",      default: 0, null: false
  # t.integer  "manage_children",     default: 0, null: false
  # t.integer  "manage_posts",        default: 0, null: false
  # t.integer  "manage_listings",     default: 0, null: false
  # t.integer  "manage_resources",    default: 0, null: false
  # t.integer  "manage_events",       default: 0, null: false
  # t.integer  "access_events",       default: 0, null: false
  # t.integer  "access_resources",    default: 0, null: false
  # t.integer  "access_statistics",   default: 0, null: false
  # t.integer  "location_id"
  # t.integer  "community_id"
  # t.datetime "created_at",                      null: false
  # t.datetime "updated_at",                      null: false
  
  
  ## Relationships
  belongs_to :parent,   class_name: :Community, foreign_key: :community_id
  has_many   :children, class_name: :Community, foreign_key: :community_id, dependent: :restrict_with_exception
  
  has_many :members, class_name: :CommunityMember, foreign_key: :community_id
  
  belongs_to :location
  
  #has_many   :outgoing_requests, as: :requestor, class_name: :Request
  #has_many   :incoming_requests, as: :actor,     class_name: :Request
  
  #has_many   :team_communities, dependent: :destroy
  #has_many   :teams,            through: :team_communities
  
  has_attached_file :logo,   styles: { fluid: "300x", medium: "300x300#", thumb: "100x100#" }, default_url: lambda { |image| ActionController::Base.helpers.asset_path("entities/Community.png") }
  has_attached_file :avatar, styles: { fluid: "300x", medium: "300x300#", thumb: "100x100#" }, default_url: lambda { |image| ActionController::Base.helpers.asset_path("entities/Community.png") }
  
  
  
  ## Validation
  validates :name, presence: true
  
  validates_attachment_content_type :logo,   :content_type => /\Aimage\/.*\Z/
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
  
  
  ## Enumerations
  enum category: [
    :university,
    :space,
    :organization,
    :other
  ]
  
  
  
  ## Scopes
  def self.roots
    self.where     community_id: nil
  end
  def self.leafs
    self.where.not community_id: nil
  end
  def self.active
    self.where     archived_at:  nil
  end
  def self.archived
    self.where.not archived_at:  nil
  end
  
  
  
  ## Tree Traversal
  # Traverse up the community tree for the root community
  def root
    if parent.nil?
    then self
    else parent.root
    end
  end
  
  # Traverse up the community tree for the nearest photo/description
  def closest_photo
    if photo.exists? || parent.nil?
    then photo
    else parent.closest_photo
    end
  end
  def closest_description
    if !description.blank? || parent.nil?
    then description
    else parent.closest_description
    end
  end
  
  # Traverse the community tree to see if another community is related to the
  #   current community
  def is_ancestor_of?(community)
    self == community || community.parent.present? && is_ancestor_of?(community.parent)
  end
  def is_descendent_of?(community)
    community.is_ancestor_of?(self)
  end
end