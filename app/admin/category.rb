ActiveAdmin.register Category do
  index do
    selectable_column
    id_column
    column :name
    column(:startups) do |e|
      link_to 'Startups', admin_category_startups_path(e)
    end
    actions
  end

  filter :name

  form do |f|
    f.inputs 'Category Details' do
      f.input :name
      f.input :description
    end
    f.actions
  end
end
