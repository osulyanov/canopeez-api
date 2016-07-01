require 'rails_helper'

describe Rating, type: :model do
  let(:user) { create :user }
  let(:category) { create :category }
  let(:startup) { create :startup, user: user, category: category }
  subject { build(:rating, user: user, startup: startup, value: 5) }

  it 'is valid' do
    expect(subject).to be_valid
  end
end

# == Schema Information
#
# Table name: ratings
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  startup_id :integer
#  value      :integer          default(0), not null
#  visible    :boolean          default(TRUE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_ratings_on_startup_id  (startup_id)
#  index_ratings_on_user_id     (user_id)
#
