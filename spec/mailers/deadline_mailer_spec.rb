require "rails_helper"

RSpec.describe DeadlineMailer, type: :mailer do
  describe "upcoming_deadline_alert" do
    let(:studio) { create(:studio) }
    let(:user) { create(:user, studio: studio) }
    let(:client) { create(:client, studio: studio) }
    let(:expediente) { create(:expediente, client: client, assigned_to: user) }
    let(:deadline) { create(:deadline, expediente: expediente, due_on: 2.days.from_now.to_date, title: "Contestar Demanda") }

    let(:mail) { DeadlineMailer.upcoming_deadline_alert(deadline, user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Aviso de Vencimiento: Contestar Demanda [#{expediente.caratula}]")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hola #{user.first_name}")
      expect(mail.body.encoded).to match(deadline.title)
    end
  end
end
