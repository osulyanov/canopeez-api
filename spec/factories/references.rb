FactoryGirl.define do
  factory :reference do
    startup
    url 'http://yandex.ru'
    description 'Yandex'
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
