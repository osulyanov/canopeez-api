ActiveAdmin.register Favorite do
  index do
    selectable_column
    id_column
    column :user
    column :startup
    actions
  end

  filter :user
  filter :startup

  form do |f|
    f.inputs 'Favorite Details' do
      f.input :user
      f.input :startup
    end
    f.actions
  end
end
