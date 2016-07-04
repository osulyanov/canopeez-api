class StartupsAddSearchData < ActiveRecord::Migration
  def change
    add_column :startups, :search_data, :text
  end
end
