ActiveAdmin.register User do
  scope :all, default: true
  scope 'Premium', &:premium
  scope 'Users', &:users
  scope 'Admins', &:admins

  index do
    selectable_column
    id_column
    column :provider
    column :email
    column :full_name
    column :role
    column :is_premium
    column(:startups) do |e|
      link_to 'Startups', admin_user_startups_path(e)
    end
    actions
  end

  filter :email
  filter :role, as: :select, collection: User.roles
  filter :is_premium

  form do |f|
    f.inputs 'User Details' do
      f.input :email
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
      f.input :role
      f.input :name
      f.input :surname
      f.input :school
      f.input :is_premium
    end
    f.actions
  end
end
