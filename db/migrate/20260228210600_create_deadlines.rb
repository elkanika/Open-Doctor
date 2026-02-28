# frozen_string_literal: true

class CreateDeadlines < ActiveRecord::Migration[8.1]
  def change
    create_table :deadlines do |t|
      t.references :studio, null: false, foreign_key: true
      t.references :expediente, null: false, foreign_key: true
      t.references :procedural_act, foreign_key: true         # Acto procesal padre (opcional)
      t.references :parent_deadline, foreign_key: { to_table: :deadlines }  # Sub-plazo

      t.string :title, null: false                   # Descripción del plazo
      t.text :description

      # ¿De quién es el plazo?
      t.integer :party, default: 0, null: false      # enum: propio, contraria

      # Fechas
      t.date :starts_on                              # Fecha desde la que corre el plazo
      t.date :due_on, null: false                    # Fecha de vencimiento
      t.date :completed_on                           # Fecha en que se cumplió

      # Configuración del plazo
      t.integer :days_count                          # Cantidad de días del plazo
      t.boolean :business_days, default: true        # ¿Días hábiles?
      t.integer :status, default: 0, null: false     # enum: pendiente, cumplido, vencido, suspendido

      # Alertas
      t.integer :alert_days_before, default: 2       # Días de anticipación para la alerta
      t.boolean :alert_sent, default: false          # ¿Se envió la alerta?

      # Dependencia de evento externo
      t.string :depends_on_event                     # Ej: "Notificación de sentencia"
      t.boolean :event_occurred, default: false       # ¿Ocurrió el evento?
      t.date :event_date                             # Cuándo ocurrió

      t.integer :priority, default: 0               # enum: normal, alta, urgente

      t.timestamps
    end

    add_index :deadlines, [:studio_id, :due_on]
    add_index :deadlines, [:expediente_id, :status]
    add_index :deadlines, :party
    add_index :deadlines, :status
  end
end
