module V1
  class Root < Grape::API
    format :json
    version "v1", using: :path
    mount V1::Users
    mount V1::Posts
  end
  # V1
end
