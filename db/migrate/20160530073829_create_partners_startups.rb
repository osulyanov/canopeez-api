class CreatePartnersStartups < ActiveRecord::Migration
  def change
    create_table :partners_startups, id: false do |t|
      t.integer :partner_id
      t.integer :startup_id
    end

    add_index :partners_startups, :partner_id
    add_index :partners_startups, :startup_id
  end
end
