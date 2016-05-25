class Reference < ActiveRecord::Base
  belongs_to :startup, required: true

  validates :url, presence: true
  validates :description, presence: true
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
#
# Indexes
#
#  index_references_on_startup_id  (startup_id)
#
