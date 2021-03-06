class Survey < ActiveRecord::Base
	has_many :questions, :dependent => :destroy, :order => "questions.qorder ASC"
	has_many :responses, :dependent => :destroy

	validates :title, :presence => true
	validates :summary, :presence => true
	validates :slug, :presence => true, :if => Proc.new {|s| !s.title.blank? }
	attr_accessible :title, :slug, :summary, :questions_attributes

	accepts_nested_attributes_for :questions, :reject_if => :all_blank, :allow_destroy => true

	QUESTION_TYPES = ["Text", "Paragraph", "Date", "Number"] 
	#Multiple Choice Single Selection", "Multipe Choice Multiple Selection", "Date"]

	extend FriendlyId
  	friendly_id :title, use: :slugged

  	def self.published
  		where("LOWER(state) = ?", 'published')
  	end

  	def published?
  		state.downcase.eql?('published')
  	end

  	def draft?
  		state.downcase.eql?('draft')
  	end

  	def closed?
  		state.downcase.eql?('closed')
  	end

	def publish!
		unless questions.empty?
			self.state = 'published'
			self.published_at = Time.now()
			self.save
			true
		else
			false
		end
	end

	def close!
		update_attribute('state', 'closed')
	end

	def draft!
		update_attribute('state', 'draft')
	end

	def response(user)
		Response.where("user_id = ? AND survey_id = ?", user.id, self.id).first
	end

end