class Ability
   include CanCan::Ability

   def initialize(user)
      @user = user || User.new # for guest

      send("guest") if @user.new_record?
      send("registered_user") if !@user.new_record? && @user.roles.empty?

      @user.roles.each { |role| send(role.name.downcase) }
   end

   def guest
   	can :read, Survey
   	can :create, User
      cannot :create, Survey
      cannot :update, Survey
   	#can :create, Session
   end

   def registered_user
   	can :read, :all
   	cannot :read, User
   	can :create, Response
      can :read, Survey do |survey|
         survey.published? 
      end
      cannot :create, Survey
   end

   def admin
   	can :manage, :all
   end

end