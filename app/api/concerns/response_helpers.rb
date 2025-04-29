module ResponseHelpers
  extend ActiveSupport::Concern

  included do
    helpers do
      def success_response(resource, serializer, meta: {}, status: 200)
        status(status)
        {
          success: true,
          data: ActiveModelSerializers::SerializableResource.new(resource, each_serializer: serializer),
          meta:
        }
      end

      def pagination_meta(paginated_collection)
        {
          current_page: paginated_collection.current_page,
          next_page: paginated_collection.next_page,
          prev_page: paginated_collection.prev_page,
          total_pages: paginated_collection.total_pages,
          total_count: paginated_collection.total_count
        }
      end

      def error_response(message = "Something went wrong", status = 500)
        error!({ success: false, error: message }, status)
      end
    end
  end
end
