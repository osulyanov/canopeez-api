FactoryGirl.define do
  factory :startup do
    user
    category
    sequence :name do |n|
      "user_#{n}@mysite.com"
    end
    is_active true
  end
end

# == Schema Information
#
# Table name: startups
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  category_id      :integer
#  name             :string
#  logo_url         :string
#  description      :text
#  pitch            :text
#  twitter_url      :string
#  facebook_url     :string
#  google_url       :string
#  linkedin_url     :string
#  youtube_url      :string
#  instagram_url    :string
#  crowdfunding_url :string
#  is_active        :boolean          default(FALSE), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_startups_on_category_id  (category_id)
#  index_startups_on_user_id      (user_id)
#
