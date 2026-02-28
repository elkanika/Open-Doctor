# frozen_string_literal: true

class CreateProceduralInstances < ActiveRecord::Migration[8.1]
  def change
    create_table :procedural_instances do |t|
      t.references :studio, null: false, foreign_key: true
      t.references :expediente, null: false, foreign_key: true

      t.string :name, null: false           # "Primera Instancia", "Cámara de Apelaciones", etc.
      t.integer :instance_type, default: 0  # enum: primera_instancia, apelacion, casacion, extraordinario
      t.integer :status, default: 0         # enum: activa, finalizada
      t.string :tribunal                    # Tribunal específico de esta instancia
      t.date :fecha_inicio
      t.date :fecha_fin
      t.integer :position, default: 0       # Orden cronológico

      t.timestamps
    end
  end
end
