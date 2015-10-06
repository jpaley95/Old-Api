class Community < ActiveRecord::Base
  ## Database Fields
  # t.string   "name",                     null: false
  # t.string   "headline"
  # t.string   "video"
  # t.string   "domains"
  # t.text     "policy"
  # t.text     "description"
  # t.string   "website"
  # t.string   "facebook"
  # t.string   "twitter"
  # t.string   "linkedin"
  # t.date     "founded_at"
  # t.datetime "archived_at"
  # t.integer  "category",                 null: false
  # t.integer  "profile_permission_id",    null: false
  # t.integer  "members_permission_id",    null: false
  # t.integer  "children_permission_id",   null: false
  # t.integer  "statistics_permission_id", null: false
  # t.integer  "posts_permission_id",      null: false
  # t.integer  "listings_permission_id",   null: false
  # t.integer  "resources_permission_id",  null: false
  # t.integer  "events_permission_id",     null: false
  # t.integer  "events_privacy_id",        null: false
  # t.integer  "resources_privacy_id",     null: false
  # t.integer  "location_id"
  # t.integer  "community_id"
  # t.datetime "created_at",               null: false
  # t.datetime "updated_at",               null: false
  
  
  
  ## Actable (MTI)
  acts_as :handle
  
  
  
  ## Relationships
  has_many :resources
  has_many :categories, through: :resources
  
  belongs_to :parent,   class_name: :Community, foreign_key: :community_id
  has_many   :children, class_name: :Community, foreign_key: :community_id, dependent: :restrict_with_exception
  
  has_many :members, class_name: :CommunityMember, foreign_key: :community_id
  
  has_and_belongs_to_many :teams, join_table: :community_teams
  
  belongs_to :location
  
  belongs_to :profile_permission,    class_name: :Permission
  belongs_to :members_permission,    class_name: :Permission
  belongs_to :children_permission,   class_name: :Permission
  belongs_to :statistics_permission, class_name: :Permission
  belongs_to :posts_permission,      class_name: :Permission
  belongs_to :listings_permission,   class_name: :Permission
  belongs_to :resources_permission,  class_name: :Permission
  belongs_to :events_permission,     class_name: :Permission
  
  belongs_to :events_privacy,    class_name: :Privacy
  belongs_to :resources_privacy, class_name: :Privacy
  
  has_one :logo,   class_name: :Image, as: :owner
  has_one :avatar, class_name: :Image, as: :owner
  
  
  
  ## Validation
  validates :name, presence: true/
  
  
  
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
  
  
  
  ## Permission
  def permission
    {
      profile:    profile_permission.name,
      members:    members_permission.name,
      children:   children_permission.name,
      statistics: statistics_permission.name,
      posts:      posts_permission.name,
      listings:   listings_permission.name,
      resources:  resources_permission.name,
      events:     events_permission.name
    }
  end
  
  
  
  ## Privacy
  def privacy
    {
      events:    events_privacy.name,
      resources: resources_privacy.name
    }
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