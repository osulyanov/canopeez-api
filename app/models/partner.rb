class Partner < ActiveRecord::Base
  mount_uploader :logo, ImageUploader

  has_and_belongs_to_many :startups

  validates :name, presence: true

  scope :alphabet, -> { order :name }
end

# == Schema Information
#
# Table name: partners
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  logo       :string
#
