# frozen_string_literal: true

class Api::V1::Users::SessionsController < Devise::SessionsController
  respond_to :json
  before_action :authenticate_user!, only: :my_account
  before_action :set_user, only: :login

  def login
    if @user.valid_password?(login_params[:password])
      render_serialized_response(AuthSerializer, @user)
    else
      not_authorized('Email or Password is incorrect. Please try again.')
    end
  end

  def my_account
    render_serialized_response(UserSerializer, current_user)
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def set_user
    @user = User.find_for_database_authentication(email: login_params[:email])

    not_authorized('Email or Password is incorrect. Please try again.') if @user.nil?
  end
end
