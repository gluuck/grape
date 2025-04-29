module ErrorHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from(ActiveRecord::RecordInvalid) do |e|
      error_response(e.record.errors.full_messages.join(", "), 422)
    end

    rescue_from(ActiveRecord::RecordNotFound) do |e|
      error_response("Record Not Found: #{e.message}", 404)
    end

    rescue_from(:all) do |e|
      error_response("Internal server error: #{e.message}", 500)
    end
  end
end
