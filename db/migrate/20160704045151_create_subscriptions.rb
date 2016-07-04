class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user, index: true
      t.references :startup, index: true

      t.timestamps null: false
    end
  end
end
