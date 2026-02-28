# frozen_string_literal: true

class CreateProceduralActs < ActiveRecord::Migration[8.1]
  def change
    create_table :procedural_acts do |t|
      t.references :studio, null: false, foreign_key: true
      t.references :procedural_instance, null: false, foreign_key: true

      t.string :name, null: false             # "Contestación de demanda", "Ofrecimiento de prueba", etc.
      t.text :description
      t.integer :status, default: 0           # enum: pendiente, en_curso, cumplido, vencido
      t.date :fecha_acto                      # Fecha en que se realizó el acto
      t.integer :position, default: 0         # Orden dentro de la instancia

      t.timestamps
    end
  end
end
