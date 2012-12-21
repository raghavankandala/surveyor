class Survey < ActiveRecord::Base
	has_many :questions, :dependent => :destroy
	has_many :responses, :dependent => :destroy

	validates :title, :presence => true
	validates :summary, :presence => true
	validates :slug, :presence => true
	attr_accessible :title, :slug, :summary

	accepts_nested_attributes_for :questions

	extend FriendlyId
  	friendly_id :title, use: :slugged

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
			update_attribute('state', 'published')
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

end