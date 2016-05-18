class UsersAddFields < ActiveRecord::Migration
  def change
    add_column :users, :role, :integer, null: false, default: 1
    add_column :users, :name, :string
    add_column :users, :surname, :string
    add_column :users, :school, :string
    add_column :users, :is_premium, :boolean, null: false, default: false
  end
end
