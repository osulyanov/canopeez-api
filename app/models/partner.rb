class Partner < ActiveRecord::Base
  has_and_belongs_to_many :startups

  validates :name, presence: true
end

# == Schema Information
#
# Table name: partners
#
#  id         :integer          not null, primary key
#  name       :string
#  logo_url   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
