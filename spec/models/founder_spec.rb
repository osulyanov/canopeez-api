require 'rails_helper'

describe Founder, type: :model do
  let(:user) { create :user }
  let(:category) { create :category }
  let(:startup) { create :startup, user: user, category: category }
  subject { build :founder, startup: startup }

  it 'is valid' do
    expect(subject).to be_valid
  end

  it 'not valid without startup' do
    subject.startup = nil

    expect(subject).not_to be_valid
  end

  it 'not valid without name' do
    subject.name = nil

    expect(subject).not_to be_valid
  end

  it 'not valid without surname' do
    subject.surname = nil

    expect(subject).not_to be_valid
  end

  describe '#full_name' do
    it 'returns the concatenated first and last name if both are present' do
      user = create(:user, name: 'Alex', surname: 'Pushkin')

      result = user.full_name

      expect(result).to eq('Alex Pushkin')
    end

    it 'returns name if name present but surname not' do
      user = build(:user, name: 'Alex', surname: '')

      result = user.full_name

      expect(result).to eq('Alex')
    end

    it 'returns surname if surname present but name not' do
      user = build(:user, name: '', surname: 'Pushkin')

      result = user.full_name

      expect(result).to eq('Pushkin')
    end

    it 'returns empty string if both name and surname not specified' do
      user = build(:user, email: 'em@il.ru', name: '', surname: '')

      result = user.full_name

      expect(result).to eq('')
    end
  end
end

# == Schema Information
#
# Table name: founders
#
#  id           :integer          not null, primary key
#  startup_id   :integer
#  name         :string
#  surname      :string
#  position     :string
#  description  :text
#  quote        :text
#  linkedin_url :string
#  photo_url    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_founders_on_startup_id  (startup_id)
#
