# frozen_string_literal: true

class CreateClients < ActiveRecord::Migration[8.1]
  def change
    create_table :clients do |t|
      t.references :studio, null: false, foreign_key: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :document_type, default: "DNI"  # DNI, CUIT, CUIL, pasaporte
      t.string :document_number
      t.string :email
      t.string :phone
      t.text :address
      t.text :notes                             # Notas sobre el cliente

      t.timestamps
    end

    add_index :clients, [:studio_id, :document_number], unique: true
  end
end
