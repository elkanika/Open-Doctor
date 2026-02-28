# frozen_string_literal: true

class Movement < ApplicationRecord
  include StudioScoped

  # === Asociaciones ===
  belongs_to :expediente
  belongs_to :user, optional: true

  # === Validaciones ===
  validates :title, presence: true
  validates :occurred_at, presence: true

  # === Scopes ===
  scope :chronological, -> { order(occurred_at: :desc) }
end
