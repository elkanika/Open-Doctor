require 'rails_helper'

RSpec.describe Deadline, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:party) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:due_on) }
  end

  describe 'associations' do
    it { should belong_to(:expediente) }
    it { should belong_to(:procedural_act).optional }
    it { should belong_to(:parent_deadline).class_name('Deadline').optional }
    it { should have_many(:sub_deadlines).class_name('Deadline').with_foreign_key('parent_deadline_id').dependent(:destroy) }
  end

  describe 'scopes and states' do
    let(:studio) { create(:studio) }
    let(:client) { create(:client, studio: studio) }
    let(:expediente) { create(:expediente, studio: studio, client: client) }
    
    it 'identifies vencidos (expired deadlines)' do
      vencido = create(:deadline, studio: studio, expediente: expediente, due_on: 1.day.ago.to_date, status: :vencido)
      vigente = create(:deadline, studio: studio, expediente: expediente, due_on: 1.day.from_now.to_date, status: :pendiente)

      expect(Deadline.vencidos).to include(vencido)
      expect(Deadline.vencidos).not_to include(vigente)
    end
  end
end
