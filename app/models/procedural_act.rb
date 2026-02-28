# frozen_string_literal: true

class ProceduralAct < ApplicationRecord
  include StudioScoped

  # === Enums ===
  enum :status, { pendiente: 0, en_curso: 1, cumplido: 2, vencido: 3 }

  # === Asociaciones ===
  belongs_to :procedural_instance
  has_many :deadlines, dependent: :nullify

  # === Validaciones ===
  validates :name, presence: true

  # === Scopes ===
  scope :ordered, -> { order(position: :asc) }
end
