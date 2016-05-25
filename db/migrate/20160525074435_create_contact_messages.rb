class CreateContactMessages < ActiveRecord::Migration
  def change
    create_table :contact_messages do |t|
      t.references :user, index: true
      t.text :message
      t.integer :action
      t.string :mail
      t.string :city
      t.string :full_name
      t.integer :type

      t.timestamps null: false
    end
  end
end
