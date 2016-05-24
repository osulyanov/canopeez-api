FactoryGirl.define do
  factory :category do
    sequence :name do |n|
      "Toys #{n}"
    end
    description 'Goods'
  end
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
