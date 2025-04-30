# spec/requests/api/v1/users_spec.rb

require "rails_helper"

RSpec.describe "V1::Users API", type: :request do
  let!(:users) { create_list(:user, 3) }

  describe "GET /api/v1/users" do
    it "returns a list of users" do
      get("/api/v1/users")
      expect(last_response).to(have_http_status(:ok))
      expect(JSON.parse(last_response.body)["data"].size).to(eq(3))
    end
  end

  describe "GET /api/v1/users/:id" do
    it "returns the user" do
      user = users.first
      get("/api/v1/users/#{user.id}")

      expect(last_response).to(have_http_status(:ok))
      expect(JSON.parse(last_response.body)["data"]["id"].to_i).to(eq(user.id))
    end
  end

  describe "POST /api/v1/users" do
    it "creates a new user" do
      post(
        "/api/v1/users",
        { name: "Test User", email: "test@example.com" }
      )
      expect(last_response).to(have_http_status(:created))
      expect(User.last.email).to(eq("test@example.com"))
    end
  end
end
