require 'rails_helper'

RSpec.describe "Clients", type: :request do
  let(:studio_a) { create(:studio, name: "Studio A") }
  let(:user_a) { create(:user, studio: studio_a, role: :titular) }
  let(:client_a) { create(:client, studio: studio_a, first_name: "Cliente", last_name: "A") }

  let(:studio_b) { create(:studio, name: "Studio B") }
  let(:user_b) { create(:user, studio: studio_b, role: :titular) }
  let(:client_b) { create(:client, studio: studio_b, first_name: "Cliente", last_name: "B") }

  before do
    # Create the clients so they exist in DB
    client_a
    client_b
  end

  describe "GET /clients" do
    context "when logged in as user of Studio A" do
      before { login_as(user_a, scope: :user) }

      it "shows only clients from Studio A" do
        get clients_path
        expect(response).to be_successful
        expect(response.body).to include("A, Cliente")
        expect(response.body).not_to include("B, Cliente")
      end
    end
  end

  describe "GET /clients/:id" do
    context "when logged in as user of Studio A" do
      before { login_as(user_a, scope: :user) }

      it "can view a client from Studio A" do
        get client_path(client_a)
        expect(response).to be_successful
      end

      it "cannot view a client from Studio B (returns 404 Not Found)" do
        get client_path(client_b)
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "POST /clients" do
    before { login_as(user_a, scope: :user) }

    it "creates a client assigned to Studio A" do
      expect {
        post clients_path, params: {
          client: {
            first_name: "Nuevo",
            last_name: "Cliente",
            document_type: "DNI",
            document_number: "12345678"
          }
        }
      }.to change(Client, :count).by(1)

      expect(response).to redirect_to(client_path(Client.last))
      expect(Client.last.studio).to eq(studio_a)
    end
  end
end
