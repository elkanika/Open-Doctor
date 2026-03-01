require 'rails_helper'

RSpec.describe Studio, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    
    describe 'slug uniqueness' do
      it 'validates uniqueness of slug' do
        create(:studio, slug: 'test-slug', name: 'Test 1')
        studio2 = build(:studio, slug: 'test-slug', name: 'Test 2')
        # Skip the callback for the test by manually setting validation
        studio2.valid?
        expect(studio2.errors[:slug]).to include("ya está en uso")
      end
    end
  end

  describe 'associations' do
    it { should have_many(:users).dependent(:destroy) }
    it { should have_many(:clients).dependent(:destroy) }
    it { should have_many(:expedientes).dependent(:destroy) }
  end

  describe 'callbacks' do
    it 'generates a slug before validation if name is present and slug is blank' do
      studio = build(:studio, name: 'Estudio Jurídico López', slug: nil)
      studio.valid?
      expect(studio.slug).to eq('estudio-juridico-lopez')
    end
  end
end
