class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :user, index: true
      t.references :startup, index: true
      t.integer :value, null: false, default: 0
      t.boolean :visible, null: false, default: true

      t.timestamps null: false
    end
  end
end
