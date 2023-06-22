# spec/support/auth_helpers.rb
module AuthHelpers
  def authenticate_user(user)
    secret = Rails.application.secrets.devise_jwt_secret_key
    encoding = 'HS512'
    
    request.headers["Authorization"] = 
      "Bearer #{JWT.encode({ user_id: user.id }, secret, encoding)}"
  end
end
