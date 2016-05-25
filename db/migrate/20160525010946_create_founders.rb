class CreateFounders < ActiveRecord::Migration
  def change
    create_table :founders do |t|
      t.references :startup, index: true
      t.string :name
      t.string :surname
      t.string :position
      t.text :description
      t.text :quote
      t.string :linkedin_url
      t.string :photo_url

      t.timestamps null: false
    end
  end
end
