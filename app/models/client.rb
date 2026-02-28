# frozen_string_literal: true

class Client < ApplicationRecord
  include StudioScoped

  # === Asociaciones ===
  has_many :expedientes, dependent: :restrict_with_error

  # === Validaciones ===
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :document_number, uniqueness: { scope: :studio_id }, allow_blank: true

  # === PaperTrail ===
  has_paper_trail

  # === Métodos ===
  def full_name
    "#{last_name}, #{first_name}"
  end
end
