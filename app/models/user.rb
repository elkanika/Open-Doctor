# frozen_string_literal: true

class User < ApplicationRecord
  include StudioScoped

  # === Devise ===
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # === Enums ===
  enum :role, { titular: 0, colaborador: 1, administrativo: 2 }

  # === Asociaciones ===
  has_many :assigned_expedientes, class_name: "Expediente", foreign_key: :assigned_to_id,
                                  dependent: :nullify, inverse_of: :assigned_to
  has_many :movements, dependent: :nullify

  # === Validaciones ===
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true

  # === PaperTrail ===
  has_paper_trail

  # === Métodos ===
  def full_name
    "#{last_name}, #{first_name}"
  end
end
