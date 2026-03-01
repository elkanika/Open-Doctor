require 'rails_helper'

RSpec.describe "Authentication", type: :request do
  let(:studio) { create(:studio) }
  let(:user) { create(:user, studio: studio, password: 'password123') }

  describe "GET /" do
    context "when not logged in" do
      it "redirects to the login page" do
        get root_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when logged in" do
      before { login_as(user, scope: :user) }

      it "returns a successful response for the dashboard" do
        get root_path
        expect(response).to be_successful
        expect(response.body).to include("Dashboard")
        expect(response.body).to include(studio.name)
      end
    end
  end

  describe "POST /users/sign_in" do
    it "logs the user in and redirects to root" do
      post user_session_path, params: {
        user: {
          email: user.email,
          password: 'password123'
        }
      }
      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include("Dashboard")
    end
  end
end
