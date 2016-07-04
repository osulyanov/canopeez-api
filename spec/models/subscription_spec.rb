require 'rails_helper'

describe Subscription, type: :model do
  let(:user) { create :user }
  let(:category) { create :category }
  let(:startup) { create :startup, user: user, category: category }
  subject { build(:subscription, user: user, startup: startup) }

  it 'is valid' do
    expect(subject).to be_valid
  end
end

# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  startup_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_subscriptions_on_startup_id  (startup_id)
#  index_subscriptions_on_user_id     (user_id)
#
