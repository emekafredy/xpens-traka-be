# frozen_string_literal: true

class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  before_action :sign_up_params, only: [:create]

  def signup
    user = User.new(sign_up_params)

    if user.save
      render_serialized_response(AuthSerializer, user)
    else
      bad_request_error(user)
    end
  end

  private

  def sign_up_params
    params.permit(:email, :password, :username)
  end
end
