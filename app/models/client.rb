# frozen_string_literal: true

class Client < ApplicationRecord
  include StudioScoped

  # === Asociaciones ===
  has_many :expedientes, dependent: :restrict_with_error
  has_many_attached :documents

  # === Validaciones ===
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :document_number, uniqueness: { scope: :studio_id }, allow_blank: true

  # === PaperTrail ===
  has_paper_trail

  # === Ransack ===
  def self.ransackable_attributes(_auth_object = nil)
    %w[first_name last_name document_number email phone]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[expedientes]
  end

  # === Métodos ===
  def full_name
    "#{last_name}, #{first_name}"
  end
end
