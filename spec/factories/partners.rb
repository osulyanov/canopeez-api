FactoryGirl.define do
  factory :partners do
    name 'Gazprom'
  end
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
