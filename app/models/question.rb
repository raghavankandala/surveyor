class Question < ActiveRecord::Base
	attr_accessible :title, :type, :survey_id
	
	belongs_to :survey

end