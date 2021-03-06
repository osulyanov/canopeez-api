class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud

    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :update, User, id: user.id

      can :read, Startup do |startup|
        startup.is_active? || startup.user_id == user.id
      end
      can [:search, :create], Startup
      can [:update, :destroy], Startup, user_id: user.id
      if user.is_premium?
        can [:have_partners, :have_references], Startup, user_id: user.id
      end

      can :read, Founder
      can :create, Founder
      can [:update, :destroy], Founder, user_id: user.id

      can :read, Reference
      can :create, Reference if user.is_premium?
      can [:update, :destroy], Reference, user_id: user.id

      can :read, Category

      can :read, Partner

      can :create, ContactMessage

      can :crud, Favorite, user_id: user.id

      can :crud, Subscription, user_id: user.id

      can [:create, :read], Rating
      can [:update, :destroy], Rating, user_id: user.id

      can [:create, :read], Comment
      can [:update, :destroy], Comment, user_id: user.id
    end
  end
end
