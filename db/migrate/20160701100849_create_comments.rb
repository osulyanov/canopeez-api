class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true
      t.references :startup, index: true
      t.text :comment
      t.boolean :visible, null: false, default: true

      t.timestamps null: false
    end
  end
end
