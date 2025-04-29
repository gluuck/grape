class Api < Grape::API
  include ErrorHandlers
  include ResponseHelpers
  format :json
  prefix :api
  version "v1", using: :path, default: true
  mount V1::Root
  get do
    { message: "API is up and running!" }
  end

  route(:any, "*path") do
    error!({ success: false, error: "Page Not Found" }, 404)
  end
end
