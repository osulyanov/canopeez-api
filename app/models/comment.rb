class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :startup

  validates :user, presence: true
  validates :startup, presence: true
  validates :comment, presence: true
end

# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  startup_id :integer
#  comment    :text
#  visible    :boolean          default(TRUE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_comments_on_startup_id  (startup_id)
#  index_comments_on_user_id     (user_id)
#
