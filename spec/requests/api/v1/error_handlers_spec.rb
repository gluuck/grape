require "rails_helper"

RSpec.describe "Error Handling in Grape API", type: :request do
  describe "POST /api/v1/users with invalid data" do
    it "returns 422 when validation fails" do
      post("/api/v1/users", { name: "" })
      expect(last_response).to(have_http_status(422))
      body = JSON.parse(last_response.body)
      expect(body["success"]).to(eq(false))
      expect(body["errors"].symbolize_keys).to(
        eq(
          {
            message: "email is missing",
            status: 422
          }
        )
      )
    end
  end

  describe "GET /api/v1/users/:id with invalid ID" do
    it "returns 404 when record is not found" do
      get("/api/v1/users/99999")
      expect(last_response).to(have_http_status(404))
      body = JSON.parse(last_response.body)
      expect(body["success"]).to(eq(false))
      expect(body["errors"].symbolize_keys).to(match(message: "Couldn't find User with 'id'=99999", status: 404))
    end
  end

  describe "POST /api/v1/users/:user_id/posts with invalid data" do
    it "returns 422 when validation fails" do
      post("/api/v1/users/1/posts", { title: "Title" })
      expect(last_response).to(have_http_status(422))
      body = JSON.parse(last_response.body)
      expect(body["success"]).to(eq(false))
      expect(body["errors"].symbolize_keys).to(
        eq(
          {
            message: "body is missing",
            status: 422
          }
        )
      )
    end
  end

  describe "GET /api/v1/users/:user_id/posts/:id with invalid ID" do
    let(:user) { create(:user) }
    it "returns 404 when record is not found" do
      get("/api/v1/users/#{user.id}/posts/99999")
      expect(last_response).to(have_http_status(404))
      body = JSON.parse(last_response.body)
      expect(body["success"]).to(eq(false))
      expect(body["errors"].symbolize_keys).to(
        match(
          message: "Couldn't find Post with 'id'=99999 [WHERE \"posts\".\"user_id\" = ?]",
          status: 404
        )
      )
    end
  end
end
