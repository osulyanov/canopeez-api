class ReferenceAddUserId < ActiveRecord::Migration
  def change
    add_column :references, :user_id, :integer, index: true
  end
end
