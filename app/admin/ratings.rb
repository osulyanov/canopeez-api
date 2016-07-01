ActiveAdmin.register Rating do
  index do
    selectable_column
    id_column
    column :user
    column :startup
    column :value
    column :visible
    actions
  end

  filter :user
  filter :startup
  filter :value
  filter :visible

  form do |f|
    f.inputs 'Rating Details' do
      f.input :user
      f.input :startup
      f.input :value
      f.input :visible
    end
    f.actions
  end
end
