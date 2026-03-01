require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }

    describe 'uniqueness scoped to studio' do
      subject { build(:client) }
      it { should validate_uniqueness_of(:document_number).scoped_to(:studio_id).case_insensitive.allow_blank }
    end
  end

  describe 'associations' do
    it { should belong_to(:studio) }
    it { should have_many(:expedientes).dependent(:restrict_with_error) }
  end

  describe '#full_name' do
    it 'returns the formatted full name' do
      client = build(:client, first_name: 'Ana', last_name: 'García')
      expect(client.full_name).to eq('García, Ana')
    end
  end
end
