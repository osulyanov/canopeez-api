ActiveAdmin.register Reference do
  permit_params :name, :description

  belongs_to :startup, optional: true

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  filter :name

  form do |f|
    f.inputs 'Reference Details' do
      f.input :name
      f.input :description
    end
    f.actions
  end
end
