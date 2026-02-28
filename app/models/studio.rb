# frozen_string_literal: true

class Studio < ApplicationRecord
  # === Multitenancy ===
  # Studio es el tenant, no incluye StudioScoped

  # === Asociaciones ===
  has_many :users, dependent: :destroy
  has_many :clients, dependent: :destroy
  has_many :expedientes, dependent: :destroy
  has_many :procedural_instances, dependent: :destroy
  has_many :procedural_acts, dependent: :destroy
  has_many :deadlines, dependent: :destroy
  has_many :movements, dependent: :destroy

  # === Validaciones ===
  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :cuit, uniqueness: true, allow_blank: true

  # === Callbacks ===
  before_validation :generate_slug, on: :create

  private

  def generate_slug
    return if slug.present?

    self.slug = name&.parameterize
  end
end
