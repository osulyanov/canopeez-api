ActiveAdmin.register Founder do
  permit_params :user_id, :startup_id, :name, :surname, :position, :description, :quote,
                :linkedin_url, :photo_url

  belongs_to :startup, optional: true

  index do
    selectable_column
    id_column
    column :startup
    column :user
    column :full_name
    column :position
    actions
  end

  filter :startup
  filter :user
  filter :name
  filter :surname
  filter :position

  form do |f|
    f.inputs 'Founder Details' do
      f.input :user
      f.input :startup
      f.input :name
      f.input :surname
      f.input :position
      f.input :description
      f.input :quote
      f.input :linkedin_url
      f.input :photo_url
    end
    f.actions
  end
end
