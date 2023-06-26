class ApplicationController < ActionController::API
  include ResponseHelper

  def authenticate_user!
    return not_authorized unless request.headers['Authorization'].present?
    @token = request.headers['Authorization'].split(' ')[1]

    begin
      @payload = JWT.decode(@token, ENV['TOKEN_SECRET_KEY'])[0]
      user_id = @payload['id']

      @current_user = User.find_by(id: user_id)

      not_authorized if @current_user.nil?
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
      not_authorized
    end
  end

  def current_user
    @current_user ||= super
  end
end
