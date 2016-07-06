ActiveAdmin.register Partner do
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
      f.input :logo, as: :file, image_preview: true
    end
    f.actions
  end
end
