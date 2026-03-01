class DeadlineMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.deadline_mailer.upcoming_deadline_alert.subject
  #
  def upcoming_deadline_alert(deadline, user)
    @deadline = deadline
    @user = user
    @expediente = deadline.expediente
    
    mail(
      to: user.email,
      subject: "Aviso de Vencimiento: #{@deadline.title} [#{@expediente.caratula}]"
    )
  end
end
