class Request < ActiveRecord::Base
  ## Database Fields
  # t.string   "message"
  # t.string   "email"
  # t.datetime "accepted_at"
  # t.datetime "denied_at"
  # t.integer  "role"
  # t.integer  "category",      null: false
  # t.integer  "requestor_id",  null: false
  # t.integer  "actor_id"
  # t.integer  "initiator_id",  null: false
  # t.integer  "terminator_id"
  # t.datetime "created_at",    null: false
  # t.datetime "updated_at",    null: false
  
  
  
  ## Relationships
  has_one :resume, class_name: :Document, as: :owner
  
  belongs_to :requestor, class_name: :Handle
  belongs_to :actor, class_name: :Handle
  
  belongs_to :initiator, class_name: :User
  belongs_to :terminator, class_name: :User
  
  
  
  ## Validation
  validates :category, presence: true
  validates :requestor, presence: true
  validates :initator, presence: true
  validate :email_or_actor_required
  
  
  
  ## Custom validation to ensure an email or an actor is present but not both
  def email_or_actor_required
    if email.blank? && actor.blank? || email.present? && actor.present?
      errors.add(:email, 'or actor must be specified, but not both')
      errors.add(:actor, 'or email must be specified, but not both')
    end
  end
  
  
  
  ## Enumerations
  enum role: [
    :owner,
    :administrator,
    :member,
    :teammate,
    :intern,
    :freelancer,
    :mentor
  ]
  enum category: [
    :team,
    :community,
    :listing
  ]
end
