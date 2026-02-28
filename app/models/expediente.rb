# frozen_string_literal: true

class Expediente < ApplicationRecord
  include StudioScoped

  # === Enums ===
  enum :status, { activo: 0, en_tramite: 1, paralizado: 2, archivado: 3, finalizado: 4 }

  # === Asociaciones ===
  belongs_to :client
  belongs_to :assigned_to, class_name: "User", optional: true, inverse_of: :assigned_expedientes

  has_many :procedural_instances, dependent: :destroy
  has_many :deadlines, dependent: :destroy
  has_many :movements, dependent: :destroy

  # === Validaciones ===
  validates :caratula, presence: true
  validates :status, presence: true

  # === PaperTrail ===
  has_paper_trail

  # === Scopes ===
  scope :activos, -> { where(status: [:activo, :en_tramite]) }
  scope :by_fuero, ->(fuero) { where(fuero: fuero) }
end
