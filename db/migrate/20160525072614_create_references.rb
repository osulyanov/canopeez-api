class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.references :startup, index: true
      t.string :url
      t.text :description

      t.timestamps null: false
    end
  end
end
