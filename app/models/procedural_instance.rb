# frozen_string_literal: true

class ProceduralInstance < ApplicationRecord
  include StudioScoped

  # === Enums ===
  enum :instance_type, { primera_instancia: 0, apelacion: 1, casacion: 2, extraordinario: 3 }
  enum :status, { activa: 0, finalizada: 1 }

  # === Asociaciones ===
  belongs_to :expediente
  has_many :procedural_acts, dependent: :destroy

  # === Validaciones ===
  validates :name, presence: true

  # === Scopes ===
  scope :ordered, -> { order(position: :asc) }
end
