ActiveAdmin.register Startup do
  permit_params :is_active, :user_id, :category_id, :name, :logo_url,
                :description, :pitch, :twitter_url, :facebook_url, :google_url,
                :linkedin_url, :youtube_url, :instagram_url, :crowdfunding_url

  scope :all, default: true
  scope 'Active', &:active

  belongs_to :category, optional: true
  belongs_to :user, optional: true

  index do
    selectable_column
    id_column
    column :name
    column :user
    column :category
    column :is_active
    column(:founders) do |e|
      link_to 'Founders', admin_startup_founders_path(e)
    end
    column(:references) do |e|
      link_to 'References', admin_startup_references_path(e)
    end
    actions
  end

  filter :name
  filter :user
  filter :category
  filter :is_active

  form do |f|
    f.inputs 'Startup Details' do
      f.input :is_active
      f.input :user
      f.input :category
      f.input :name
      f.input :logo_url
      f.input :description
      f.input :pitch
      f.input :twitter_url
      f.input :facebook_url
      f.input :google_url
      f.input :linkedin_url
      f.input :youtube_url
      f.input :instagram_url
      f.input :crowdfunding_url
    end
    f.actions
  end
end
