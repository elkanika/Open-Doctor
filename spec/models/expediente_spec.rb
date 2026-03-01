require 'rails_helper'

RSpec.describe Expediente, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:caratula) }
    it { should validate_presence_of(:status) }
  end

  describe 'associations' do
    it { should belong_to(:client) }
    it { should belong_to(:assigned_to).class_name('User').optional }
    it { should have_many(:procedural_instances).dependent(:destroy) }
    it { should have_many(:deadlines).dependent(:destroy) }
    it { should have_many(:movements).dependent(:destroy) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(
      activo: 0,
      en_tramite: 1,
      paralizado: 2,
      archivado: 3,
      finalizado: 4
    ) }
  end
end
