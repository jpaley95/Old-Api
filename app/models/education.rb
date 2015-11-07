class Education < ActiveRecord::Base
  ## Database Fields
  # t.integer  "school_id"
  # t.string   "school_name"
  # t.integer  "degree_id",   null: false
  # t.date     "started_at"
  # t.date     "finished_at"
  # t.text     "grades"
  # t.text     "activities"
  # t.text     "classes"
  # t.text     "honors"
  # t.text     "description"
  # t.integer  "user_id",     null: false
  # t.datetime "created_at",  null: false
  # t.datetime "updated_at",  null: false
  
  
  ## Relationships
  belongs_to :user
  belongs_to :school
  belongs_to :degree
  has_and_belongs_to_many :majors, class_name: :Field, join_table: :majors
  has_and_belongs_to_many :minors, class_name: :Field, join_table: :minors
  
  
  ## Validation
  validates :user,   presence: true
  validates :degree, presence: true
  validate :only_one_school_specified
  
  
  ## Custom validator to make sure an Education record either has a related
  ##   School record or a custom school_name field
  def only_one_school_specified
    unless school.blank? ^ school_name.blank?
      errors.push(:school, 'is required and only one may be specified')
    end
  end
  
  
  ## Intercept majors/minors setters and call Tag factory method
  def majors=(majors)
    super(Tag.construct majors)
  end
  def minors=(minors)
    super(Tag.construct minors)
  end
  
  
  ## Intercept degree setter and call Degree factory method
  def degree=(degree)
    super(Degree.construct(degree).first)
  end
end