FactoryGirl.define do
  factory :contact_message do
    message 'Hey folks'
  end
end

# == Schema Information
#
# Table name: contact_messages
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  message    :text
#  action     :integer
#  mail       :string
#  city       :string
#  full_name  :string
#  kind       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_contact_messages_on_user_id  (user_id)
#
