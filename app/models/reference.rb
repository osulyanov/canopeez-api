class Reference < ActiveRecord::Base
  belongs_to :startup, required: true

  validates :url, presence: true
  validates :description, presence: true

  before_save :set_user

  def set_user
    self.user_id = startup.user_id
  end
end

# == Schema Information
#
# Table name: references
#
#  id          :integer          not null, primary key
#  startup_id  :integer
#  url         :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
# Indexes
#
#  index_references_on_startup_id  (startup_id)
#
