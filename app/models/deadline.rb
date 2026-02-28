# frozen_string_literal: true

class Deadline < ApplicationRecord
  include StudioScoped

  # === Enums ===
  enum :party, { propio: 0, contraria: 1 }
  enum :status, { pendiente: 0, cumplido: 1, vencido: 2, suspendido: 3 }
  enum :priority, { normal: 0, alta: 1, urgente: 2 }

  # === Asociaciones ===
  belongs_to :expediente
  belongs_to :procedural_act, optional: true
  belongs_to :parent_deadline, class_name: "Deadline", optional: true, inverse_of: :sub_deadlines
  has_many :sub_deadlines, class_name: "Deadline", foreign_key: :parent_deadline_id,
                           dependent: :destroy, inverse_of: :parent_deadline

  # === Validaciones ===
  validates :title, presence: true
  validates :due_on, presence: true
  validates :party, presence: true
  validates :status, presence: true

  # === PaperTrail ===
  has_paper_trail

  # === Scopes ===
  scope :pendientes, -> { where(status: :pendiente) }
  scope :propios, -> { where(party: :propio) }
  scope :de_contraria, -> { where(party: :contraria) }
  scope :vencidos, -> { where(status: :vencido) }
  scope :proximos, ->(days = 7) { pendientes.where(due_on: ..days.days.from_now.to_date) }
  scope :urgentes, -> { where(priority: :urgente) }
  scope :by_due_date, -> { order(due_on: :asc) }

  # === Métodos ===
  def vencido?
    pendiente? && due_on < Date.current
  end

  def dias_restantes
    return nil unless pendiente?

    (due_on - Date.current).to_i
  end

  def requiere_alerta?
    return false unless pendiente?
    return false if alert_sent?

    dias_restantes.present? && dias_restantes <= alert_days_before
  end
end
