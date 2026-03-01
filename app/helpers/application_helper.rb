# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  # === Active link para sidebar ===
  def active_link?(controller_name)
    params[:controller] == controller_name ? "active" : ""
  end

  # === Badges de estado ===
  def status_badge(status, type = :expediente)
    colors = case type
             when :expediente
               { "activo" => "badge-success", "en_tramite" => "badge-info",
                 "paralizado" => "badge-warning", "archivado" => "badge-gray",
                 "finalizado" => "badge-purple" }
             when :deadline
               { "pendiente" => "badge-info", "cumplido" => "badge-success",
                 "vencido" => "badge-danger", "suspendido" => "badge-gray" }
             else
               {}
             end

    labels = case type
             when :expediente
               { "activo" => "Activo", "en_tramite" => "En trámite",
                 "paralizado" => "Paralizado", "archivado" => "Archivado",
                 "finalizado" => "Finalizado" }
             when :deadline
               { "pendiente" => "Pendiente", "cumplido" => "Cumplido",
                 "vencido" => "Vencido", "suspendido" => "Suspendido" }
             else
               {}
             end

    css = colors[status.to_s] || "badge-gray"
    label = labels[status.to_s] || status.to_s.humanize
    tag.span(label, class: "badge #{css}")
  end

  # === Badge de prioridad ===
  def priority_badge(priority)
    colors = { "normal" => "badge-info", "alta" => "badge-warning", "urgente" => "badge-danger" }
    labels = { "normal" => "Normal", "alta" => "Alta", "urgente" => "Urgente" }

    css = colors[priority.to_s] || "badge-gray"
    label = labels[priority.to_s] || priority.to_s.humanize
    tag.span(label, class: "badge #{css}")
  end

  # === Badge de parte ===
  def party_badge(party)
    colors = { "propio" => "badge-info", "contraria" => "badge-warning" }
    labels = { "propio" => "Propio", "contraria" => "Contraria" }

    css = colors[party.to_s] || "badge-gray"
    label = labels[party.to_s] || party.to_s.humanize
    tag.span(label, class: "badge #{css}")
  end

  # === Formato de fecha argentina ===
  def fecha(date)
    return "—" unless date

    l(date, format: :default)
  end

  # === Moneda argentina ===
  def moneda(amount, currency = "ARS")
    return "—" unless amount

    symbol = currency == "USD" ? "US$" : "$"
    "#{symbol} #{number_with_delimiter(amount, delimiter: '.', separator: ',')}"
  end

  # === Días restantes con color ===
  def dias_restantes_tag(deadline)
    dias = deadline.dias_restantes
    return tag.span("Cumplido", class: "text-emerald-600 font-medium") if deadline.cumplido?
    return tag.span("Vencido", class: "countdown-danger") if deadline.vencido? || (dias && dias < 0)
    return "—" unless dias

    css = if dias <= 2
            "countdown-danger"
          elsif dias <= 5
            "countdown-warning"
          else
            "countdown-ok"
          end

    label = dias == 0 ? "Hoy" : (dias == 1 ? "Mañana" : "#{dias} días")
    tag.span(label, class: css)
  end

  # === Barra de prioridad ===
  def priority_bar(priority)
    tag.div(class: "priority-bar priority-#{priority}")
  end

  # === Clases para badges del calendario ===
  def calendar_badge_classes(deadline)
    return "bg-gray-100 text-gray-500 border-gray-200" if deadline.cumplido?
    return "bg-red-50 text-red-700 border-red-200" if deadline.vencido?

    base_classes = if deadline.party == "propio"
                     "bg-blue-50 border-blue-200 text-blue-800"
                   else
                     "bg-gray-50 border-gray-200 text-gray-700"
                   end

    priority_classes = case deadline.priority
                       when "urgente" then "border-l-4 border-l-red-500"
                       when "alta" then "border-l-4 border-l-orange-500"
                       else "border-l-4 border-l-transparent"
                       end

    "#{base_classes} #{priority_classes}"
  end
end
