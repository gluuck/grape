module V1
  class Posts < Grape::API
    format :json
    version "v1", using: :path
    resource(:posts) do
      get do
        Post.includes(:user).all
      end
    end

    helpers do
      def current_user
        @current_user ||= User.find(params[:user_id])
      end
    end

    get("users/:user_id/posts") do
      posts = current_user.posts.page(params[:page]).per(params[:per_page] || 20)
      success_response posts, PostSerializer, meta: pagination_meta(posts)
    end

    desc "Create a post"
    params do
      requires :title, type: String
      requires :body, type: String
    end

    post("users/:user_id/posts") do
      post = current_user.posts.create!(declared(params, include_missing: false))
      success_response post, PostSerializer, status: :created
    end

    get("users/:user_id/posts/:id/") do
      post = current_user.posts.find(params[:id])
      success_response post, PostSerializer
    end
  end
end
