class Founder < ActiveRecord::Base
  belongs_to :startup, required: true

  validates :name, presence: true
  validates :surname, presence: true
end

# == Schema Information
#
# Table name: founders
#
#  id           :integer          not null, primary key
#  startup_id   :integer
#  name         :string
#  surname      :string
#  position     :string
#  description  :text
#  quote        :text
#  linkedin_url :string
#  photo_url    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_founders_on_startup_id  (startup_id)
#
