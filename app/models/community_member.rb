class CommunityMember < ActiveRecord::Base
  # Database Fields
  # t.integer  "user_id",      null: false
  # t.integer  "community_id", null: false
  # t.integer  "role_id",      null: false
  # t.datetime "created_at",   null: false
  # t.datetime "updated_at",   null: false
  
  
  ## Relationships
  belongs_to :user
  belongs_to :role
  belongs_to :community
  
  
  ## Validation
  validates :user,      presence: true
  validates :role,      presence: true
  validates :community, presence: true
  validate :role_must_be_in_whitelist
  
  
  ## Custom validation for role
  def self.role_whitelist
    ['owner', 'administrator', 'member']
  end
  def role_must_be_in_whitelist
    unless self.role_whitelist.include? role.name
      errors.add(:role, 'must be one of the following: "' + self.role_whitelist.join('", "') + '"')
    end
  end
  
  
  ## Intercept role setter
  def role=(role)
    super(Role.construct(role).first)
  end
end
