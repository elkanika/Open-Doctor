require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:role) }
  end

  describe 'associations' do
    it { should belong_to(:studio) }
  end

  describe 'enums' do
    it { should define_enum_for(:role).with_values(titular: 0, colaborador: 1, administrativo: 2) }
  end

  describe '#full_name' do
    it 'returns the users first and last name concatenated' do
      user = build(:user, first_name: 'Juan', last_name: 'Pérez')
      expect(user.full_name).to eq('Pérez, Juan')
    end
  end
end
