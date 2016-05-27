class Category < ActiveRecord::Base
  has_many :startups
  validates :name, presence: true

  scope :alphabet, -> { order :name }
end

# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
