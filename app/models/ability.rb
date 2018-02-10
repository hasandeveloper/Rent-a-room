class Ability
  include CanCan::Ability

  def initialize(user)
     if user.role? "guest"
       can :read,[City,Room]
       can :create,[Room]

     elsif user.role? "admin"
       can :manage,[City,Room,Amenity,Permission]

     elsif user.role? "host"
       can :myrooms, [Room]
       can :read, [City, Room]
       can :create, [Room]
       can [:update, :destroy], Room do |room|
         room.user_id == user.id

    end

  end
end
end
