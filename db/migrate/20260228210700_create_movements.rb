# frozen_string_literal: true

class CreateMovements < ActiveRecord::Migration[8.1]
  def change
    create_table :movements do |t|
      t.references :studio, null: false, foreign_key: true
      t.references :expediente, null: false, foreign_key: true
      t.references :user, foreign_key: true          # Quién registró el movimiento

      t.string :title, null: false                    # Título del movimiento
      t.text :description                             # Detalle
      t.datetime :occurred_at, null: false            # Cuándo ocurrió
      t.string :movement_type                         # Tipo: escrito, resolución, notificación, etc.

      t.timestamps
    end

    add_index :movements, [:expediente_id, :occurred_at]
  end
end
