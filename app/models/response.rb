class Response < ActiveRecord::Base
  serialize :data, ActiveRecord::Coders::Hstore
  belongs_to :survey
  belongs_to :user

  attr_accessible :data, :survey_id, :user_id
end
