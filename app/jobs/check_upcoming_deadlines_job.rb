class CheckUpcomingDeadlinesJob < ApplicationJob
  queue_as :default

  def perform
    # Buscar plazos pendientes que vencen en los próximos 2 días
    deadlines = Deadline.pendientes.where("due_on <= ?", 2.days.from_now.to_date)
    
    deadlines.each do |deadline|
      # Notificar al abogado asignado, o a todos los del estudio si no hay asignado
      users_to_notify = if deadline.expediente.assigned_to
                          [deadline.expediente.assigned_to]
                        else
                          deadline.expediente.studio.users
                        end
      
      users_to_notify.each do |user|
        DeadlineMailer.upcoming_deadline_alert(deadline, user).deliver_later
      end
    end
  end
end
