module ResponseHelper
  def render_serialized_response(serializer, result)
    render json: serializer.new(result).serialized_response
  end

  def record_not_found(record = 'Record')
    render json: {
      status: {
        code: 404,
        message: "Not found. #{record} does not exist"
      }
    }, status: :not_found
  end

  def not_authorized(code = 401, message = 'You are not authorized to perform this action.', status = :unauthorized)
    render json: {
      status: {
        code: code,
        message: message
      }
    }, status: status
  end

  def bad_request_error(record, status = :bad_request, code = 400)
    render json: {
      status: {
        code: code,
        message: "Error: #{record.errors.full_messages.to_sentence}"
      }
    }, status: status
  end

  def render_success(message = "Success", serializer, result)
    render json: {
      status: {
        code: 200,
        message: message
      },
      data: serializer.new(result).serializable_hash[:data],
    }, status: :ok
  end

  def render_success_without_data(message = "Success")
    render json: {
      status: {
        code: 200,
        message: message
      }
    }, status: :ok
  end
end
