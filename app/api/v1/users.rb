module V1
  class Users < Grape::API
    format :json
    version "v1", using: :path
    resource(:users) do
      get do
        users = User.page(params[:page]).per(params[:per_page] || 20)
        success_response(users, UserSerializer, meta: pagination_meta(users))
      end
    end

    get("users/:id") do
      user = User.find(params[:id])
      success_response(user, UserSerializer)
    end

    desc "Create user"
    params do
      requires :name, type: String
      requires :email, type: String
    end

    post(:users) do
      user = User.create!(declared(params, include_missing: false))
      success_response(user, UserSerializer, meta: { id: user.id }, status: :created)
    end
  end
end
