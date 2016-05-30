require 'rails_helper'

describe Reference, type: :model do
  subject { build :reference }

  it 'is valid' do
    expect(subject).to be_valid
  end

  it 'not valid without startup' do
    subject.startup = nil

    expect(subject).not_to be_valid
  end

  it 'not valid without url' do
    subject.url = nil

    expect(subject).not_to be_valid
  end

  it 'not valid without description' do
    subject.description = nil

    expect(subject).not_to be_valid
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
