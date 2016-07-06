FactoryGirl.define do
  factory :partner do
    name 'Gazprom'
  end
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
