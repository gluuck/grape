require "rails_helper"

RSpec.describe "V1::Posts API", type: :request do
  let!(:user) { create(:user) }
  let!(:posts) { create_list(:post, 3, user: user) }

  describe "GET /api/v1/posts" do
    it "returns all posts" do
      get("/api/v1/posts")
      expect(last_response.status).to(eq(200))
      expect(JSON.parse(last_response.body).size).to(eq(3))
    end
  end

  describe "GET /api/v1/users/:user_id/posts" do
    it "returns user posts with pagination" do
      get("/api/v1/users/#{user.id}/posts")
      expect(last_response.status).to(eq(200))
      data = JSON.parse(last_response.body)
      expect(data["data"].size).to(eq(3))
    end
  end

  describe "POST /api/v1/users/:user_id/posts" do
    it "creates a new post" do
      post("/api/v1/users/#{user.id}/posts", { title: "New Post", body: "Hello World" })
      expect(last_response.status).to(eq(201))
      expect(JSON.parse(last_response.body)["data"]["title"]).to(eq("New Post"))
    end
  end

  describe "GET /api/v1/users/:user_id/posts/:id" do
    it "returns the specified post" do
      post = posts.first
      get("/api/v1/users/#{user.id}/posts/#{post.id}")
      expect(last_response.status).to(eq(200))
      expect(JSON.parse(last_response.body)["data"]["id"]).to(eq(post.id))
    end
  end
end
