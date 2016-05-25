class FounderAddUserId < ActiveRecord::Migration
  def change
    add_column :founders, :user_id, :integer, index: true
  end
end
