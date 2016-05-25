class ContactMessage < ActiveRecord::Base
  enum action: { reach: 1, reference: 2 }
  enum kind: { company: 1, individual: 2 }

  belongs_to :user
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
