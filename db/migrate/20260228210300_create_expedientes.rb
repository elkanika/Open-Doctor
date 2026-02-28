# frozen_string_literal: true

class CreateExpedientes < ActiveRecord::Migration[8.1]
  def change
    create_table :expedientes do |t|
      t.references :studio, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.references :assigned_to, foreign_key: { to_table: :users }  # Abogado asignado

      # Datos de la carátula
      t.string :caratula, null: false            # Ej: "García c/ Pérez s/ daños y perjuicios"
      t.string :numero_causa                      # Número de expediente en el juzgado
      t.string :juzgado                           # Juzgado interviniente
      t.string :fuero                             # Civil, Penal, Laboral, Comercial, etc.
      t.string :jurisdiccion, default: "Nacional" # Nacional, Provincial, Federal

      # Estado y tipo
      t.integer :status, default: 0, null: false  # enum: activo, en_tramite, paralizado, archivado, finalizado
      t.string :tipo_proceso                      # Ordinario, sumarísimo, ejecutivo, etc.
      t.string :materia                           # Daños, familia, laboral, etc.

      # Parte que representa
      t.string :parte, default: "actor"           # actor, demandado

      # Montos
      t.decimal :monto_reclamado, precision: 15, scale: 2
      t.string :moneda, default: "ARS"            # ARS, USD

      t.date :fecha_inicio                        # Fecha de inicio de la causa
      t.text :descripcion                         # Descripción libre

      t.timestamps
    end

    add_index :expedientes, [:studio_id, :numero_causa]
    add_index :expedientes, :status
    add_index :expedientes, :fuero
  end
end
