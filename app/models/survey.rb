class Survey < ActiveRecord::Base
	has_many :questions, :dependent => :destroy
	has_many :responses, :dependent => :destroy

	validates :title, :presence => true
	validates :slug, :presence => true
	validates :summary, :presence => true

	attr_accessible :title, :slug, :summary

	accepts_nested_attributes_for :questions

	def publish!
		update_attribute('published', true) unless questions.empty?
	end

	def close!
		update_attribute('closed', true)
	end
end