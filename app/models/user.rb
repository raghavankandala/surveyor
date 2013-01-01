class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username
  # attr_accessible :title, :body

  validates :username, :presence => true

  has_many :roles_users
  has_many :roles, :through => :roles_users

  def role?(role)
    _roles = roles.map(&:name)
    _role = role.to_s
    _roles.include? _role
  end

  def taken?(survey)
    Response.where("survey_id = ? AND user_id = ?", survey.id, self.id).first.nil? ? false : true
  end

end