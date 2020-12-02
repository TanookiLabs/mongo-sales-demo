RSpec.describe User, type: :model do
  subject { build(:user) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:role) }

  describe 'superuser?' do
    it 'returns false for a standard user' do
      expect(subject.superuser?).to be false
    end

    it 'returns true for an admin' do
      subject.role = :admin
      expect(subject.superuser?).to be true
    end

    it 'returns true for a developer' do
      subject.role = :developer
      expect(subject.superuser?).to be true
    end
  end

  describe 'full_name' do
    it 'returns a full name' do
      subject.first_name = Faker::Name.first_name
      subject.last_name = Faker::Name.last_name
      expect(subject.full_name).to eq("#{subject.first_name} #{subject.last_name}")
    end
  end

end
