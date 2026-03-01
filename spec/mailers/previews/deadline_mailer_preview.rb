# Preview all emails at http://localhost:3000/rails/mailers/deadline_mailer
class DeadlineMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/deadline_mailer/upcoming_deadline_alert
  def upcoming_deadline_alert
    studio = Studio.first || Studio.create!(name: "Test Studio", slug: "test_studio")
    user = User.first || User.create!(studio: studio, email: "test@example.com", password: "password", first_name: "Test", last_name: "User")
    client = Client.first || Client.create!(studio: studio, first_name: "Client", last_name: "Test")
    expediente = Expediente.first || Expediente.create!(client: client, caratula: "Test Case", numero_causa: "123")
    deadline = Deadline.first || Deadline.create!(expediente: expediente, title: "Test Deadline", due_on: 3.days.from_now)

    DeadlineMailer.upcoming_deadline_alert(deadline, user)
  end

end
