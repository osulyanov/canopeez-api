class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud

    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :update, User, id: user.id

      can :read, Startup, is_active: true
      can :crud, Startup, user_id: user.id
    end
  end
end
