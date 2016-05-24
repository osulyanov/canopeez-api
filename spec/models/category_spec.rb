require 'rails_helper'

describe Category, type: :model do
  subject { build(:category) }

  it 'is valid' do
    expect(subject).to be_valid
  end

  it 'not valid without name' do
    subject.name = nil

    expect(subject).not_to be_valid
  end

  it 'valid without description' do
    subject.description = nil

    expect(subject).to be_valid
  end
end

# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
