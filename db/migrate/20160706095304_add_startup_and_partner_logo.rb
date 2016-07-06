class AddStartupAndPartnerLogo < ActiveRecord::Migration
  def change
    remove_column :startups, :logo_url, :string
    add_column :startups, :logo, :string
    remove_column :partners, :logo_url, :string
    add_column :partners, :logo, :string
  end
end
