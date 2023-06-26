# frozen_string_literal: true

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

  def not_authorized(message = 'You are not authorized to perform this action.')
    render json: {
      status: {
        code: 401,
        message: message
      }
    }, status: :unauthorized
  end

  def bad_request_error(record, status = :bad_request, code = 400)
    render json: {
      status: {
        code: code,
        message: "Error: #{record.errors.full_messages.to_sentence}"
      }
    }, status: status
  end

  def render_success_without_data(message = 'Success')
    render json: {
      status: {
        code: 200,
        message: message
      }
    }, status: :ok
  end
end
