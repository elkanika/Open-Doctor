# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    @expedientes_activos = Expediente.activos.count
    @plazos_pendientes = Deadline.pendientes.count
    @clientes_total = Client.count
    @plazos_vencidos = Deadline.vencidos.count

    @plazos_proximos = Deadline.pendientes
                               .by_due_date
                               .includes(:expediente)
                               .limit(10)

    @expedientes_recientes = Expediente.includes(:client, :assigned_to)
                                       .order(updated_at: :desc)
                                       .limit(5)
  end
end
