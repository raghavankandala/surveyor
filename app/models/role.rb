class Role < ActiveRecord::Base

	validates :name, :presence => true
	validates :name, :uniqueness => true

	has_many :roles_users, :dependent => :delete_all
	has_many :users, :through => :roles_users

	attr_accessible :name

end