class StratupsAddSubmitForReview < ActiveRecord::Migration
  def change
    add_column :startups, :submit_for_review, :boolean, null: false,
               default: false
  end
end
