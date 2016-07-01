ActiveAdmin.register ContactMessage do
  index do
    selectable_column
    id_column
    column :user
    column :message
    actions
  end

  filter :user
  filter :message

  form do |f|
    f.inputs 'Contact Message Details' do
      f.input :user
      f.input :message
      f.input :action, as: :select, collection: ContactMessage.actions.keys
      f.input :mail
      f.input :city
      f.input :full_name
      f.input :kind, as: :select, collection: ContactMessage.kinds.keys
    end
    f.actions
  end
end
