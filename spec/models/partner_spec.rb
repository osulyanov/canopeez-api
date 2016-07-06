require 'rails_helper'

describe Partner, type: :model do
  subject { build :partner }

  it 'is valid' do
    expect(subject).to be_valid
  end

  it 'not valid without name' do
    subject.name = nil

    expect(subject).not_to be_valid
  end
end

# == Schema Information
#
# Table name: partners
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  logo       :string
#
