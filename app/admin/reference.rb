ActiveAdmin.register Reference do
  permit_params :startup_id, :url, :description

  belongs_to :startup, optional: true

  index do
    selectable_column
    id_column
    column :user
    column :startup
    column :url
    column(:description) { |e| truncate e.description, length: 100 }
    actions
  end

  filter :name

  form do |f|
    f.inputs 'Reference Details' do
      f.input :startup
      f.input :url
      f.input :description
    end
    f.actions
  end
end
