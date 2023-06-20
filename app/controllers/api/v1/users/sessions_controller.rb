# frozen_string_literal: true

class Api::V1::Users::SessionsController < Devise::SessionsController
  include RackSessionFix

  respond_to :json
  before_action :authenticate_user!, only: :my_account

  def my_account
    render_serialized_response(UserSerializer, current_user)
  end

  private

  def respond_with(resource, _opts = {})
    render_success("Login successful.", UserSerializer, resource)
  end

  def respond_to_on_destroy
    if current_user
      render json: {
        status: 200,
        message: "Logout successful"
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Logout error: Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end
