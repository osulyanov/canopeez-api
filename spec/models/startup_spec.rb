require 'rails_helper'

describe Startup, type: :model do
  let(:user) { create :user }
  let(:category) { create :category }
  subject { build(:startup, user: user, category: category) }

  it 'is valid' do
    expect(subject).to be_valid
  end

  it 'not valid without category' do
    subject.category = nil

    expect(subject).not_to be_valid
  end

  it 'not valid without name' do
    subject.name = nil

    expect(subject).not_to be_valid
  end

  it 'valid without user' do
    subject.user = nil

    expect(subject).to be_valid
  end

  describe '#cleanup_founders' do
    let(:startup) { create :startup, user: user }
    let!(:founder) { create :founder, startup: startup }

    xit 'resets startup_id' do
      startup.destroy
      founder.reload

      result = founder.startup_id

      expect(result).to be_nil
    end
  end
end

# == Schema Information
#
# Table name: startups
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  category_id       :integer
#  name              :string
#  description       :text
#  pitch             :text
#  twitter_url       :string
#  facebook_url      :string
#  google_url        :string
#  linkedin_url      :string
#  youtube_url       :string
#  instagram_url     :string
#  crowdfunding_url  :string
#  is_active         :boolean          default(FALSE), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  submit_for_review :boolean          default(FALSE), not null
#  search_data       :text
#  logo              :string
#
# Indexes
#
#  index_startups_on_category_id  (category_id)
#  index_startups_on_user_id      (user_id)
#
