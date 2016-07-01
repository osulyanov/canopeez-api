require 'rails_helper'

describe Comment, type: :model do
  let(:user) { create :user }
  let(:category) { create :category }
  let(:startup) { create :startup, user: user, category: category }
  subject { build(:comment, user: user, startup: startup, comment: 'Wow!') }

  it 'is valid' do
    expect(subject).to be_valid
  end
end

# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  startup_id :integer
#  comment    :text
#  visible    :boolean          default(TRUE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_comments_on_startup_id  (startup_id)
#  index_comments_on_user_id     (user_id)
#
