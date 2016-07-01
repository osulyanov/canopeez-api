class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :startup

  validates :value, inclusion: { in: 1..5 }
end

# == Schema Information
#
# Table name: ratings
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  startup_id :integer
#  value      :integer          default(0), not null
#  visible    :boolean          default(TRUE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_ratings_on_startup_id  (startup_id)
#  index_ratings_on_user_id     (user_id)
#
