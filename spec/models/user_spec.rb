require 'rails_helper'

describe User, type: :model do
  subject { build(:user) }

  it 'is valid' do
    expect(subject).to be_valid
  end

  it 'not valid without email' do
    subject.email = nil

    expect(subject).not_to be_valid
  end

  it 'not valid without password' do
    subject.password = nil

    expect(subject).not_to be_valid
  end

  it 'default role is user' do
    expect(subject).to be_user
  end

  describe '#display_name' do
    it 'returns the concatenated first and last name if both are present' do
      user = create(:user, name: 'Alex', surname: 'Pushkin')

      result = user.display_name

      expect(result).to eq('Alex Pushkin')
    end

    it 'returns name if name present but surname not' do
      user = build(:user, name: 'Alex', surname: '')

      result = user.display_name

      expect(result).to eq('Alex')
    end

    it 'returns surname if surname present but name not' do
      user = build(:user, name: '', surname: 'Pushkin')

      result = user.display_name

      expect(result).to eq('Pushkin')
    end

    it 'returns email if both name and surname not specified' do
      user = build(:user, email: 'em@il.ru', name: '', surname: '')

      result = user.display_name

      expect(result).to eq('em@il.ru')
    end
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
