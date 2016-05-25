ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :role, :name,
                :surname, :school, :is_premium

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
