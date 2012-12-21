class Response < ActiveRecord::Base
  serialize :data, ActiveRecord::Coders::Hstore
  belongs_to :question
  belongs_to :user

  attr_accessible :data
end
