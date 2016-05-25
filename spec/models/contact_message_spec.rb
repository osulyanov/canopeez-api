require 'rails_helper'

describe ContactMessage, type: :model do
  subject { build :contact_message }

  it 'is valid' do
    expect(subject).to be_valid
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
#  type       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_contact_messages_on_user_id  (user_id)
#
