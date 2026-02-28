# frozen_string_literal: true

class CreateStudios < ActiveRecord::Migration[8.1]
  def change
    create_table :studios do |t|
      t.string :name, null: false                    # Nombre del estudio (ej: "Pérez & Asociados")
      t.string :slug, null: false                    # URL-friendly identifier
      t.string :cuit                                 # CUIT del estudio
      t.string :email                                # Email de contacto
      t.string :phone                                # Teléfono
      t.text :address                                # Dirección
      t.string :timezone, default: "Buenos Aires"    # Zona horaria
      t.jsonb :notification_preferences, default: {} # Preferencias de notificación
      t.string :plan, default: "free"                # Plan de suscripción

      t.timestamps
    end

    add_index :studios, :slug, unique: true
    add_index :studios, :cuit, unique: true
  end
end
