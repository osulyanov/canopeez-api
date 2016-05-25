ActiveAdmin.register Partner do
  permit_params :name, :logo_url

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  filter :name

  form do |f|
    f.inputs 'Partner Details' do
      f.input :name
      f.input :logo_url
    end
    f.actions
  end
end
