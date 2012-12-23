class Question < ActiveRecord::Base
	attr_accessible :title, :qtype, :survey_id, :qorder
	
	belongs_to :survey

end