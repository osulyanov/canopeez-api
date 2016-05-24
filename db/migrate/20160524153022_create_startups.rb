class CreateStartups < ActiveRecord::Migration
  def change
    create_table :startups do |t|
      t.references :user, index: true
      t.references :category, index: true
      t.string :name
      t.string :logo_url
      t.text :description
      t.text :pitch
      t.string :twitter_url
      t.string :facebook_url
      t.string :google_url
      t.string :linkedin_url
      t.string :youtube_url
      t.string :instagram_url
      t.string :crowdfunding_url
      t.boolean :is_active

      t.timestamps null: false
    end
  end
end
