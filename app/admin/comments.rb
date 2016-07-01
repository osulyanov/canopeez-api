ActiveAdmin.register Comment do
  index do
    selectable_column
    id_column
    column :user
    column :startup
    column :visible
    actions
  end

  filter :user
  filter :startup
  filter :comment
  filter :visible

  form do |f|
    f.inputs 'Comment Details' do
      f.input :user
      f.input :startup
      f.input :comment
      f.input :visible
    end
    f.actions
  end
end
