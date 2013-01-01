class Response < ActiveRecord::Base
  serialize :data, ActiveRecord::Coders::Hstore
  belongs_to :survey
  belongs_to :user

  attr_accessible :data, :survey_id, :user_id

  validates :survey_id, :presence => true
  validates :user_id, :presence => true
  validates_with DynamicValidator

  before_save :can_take_survey?

  def can_take_survey?
  	puts "====================> #{user.taken?(survey)}"
  	if user.taken?(survey)
  		errors[:base] << "You have already taken the survey" 
  		return false
  	end
  end

end