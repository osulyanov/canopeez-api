class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :startup
end

# == Schema Information
#
# Table name: favorites
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  startup_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_favorites_on_startup_id  (startup_id)
#  index_favorites_on_user_id     (user_id)
#
