module ErrorHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from(ActiveRecord::RecordInvalid) do |e|
      error!({ success: false, errors: { message: e.record.errors.full_messages.join(", ") } }, 422)
    end

    rescue_from(ActiveRecord::RecordNotFound) do |e|
      error!({ success: false, errors: { message: e.message, status: 404 } }, 404)
    end

    rescue_from(Grape::Exceptions::ValidationErrors) do |e|
      error!({ success: false, errors: { message: e.message, status: 422 } }, 422)
    end
  end
end
