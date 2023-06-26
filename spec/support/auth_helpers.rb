# frozen_string_literal: true

module AuthHelpers
  def authenticate_user(user)
    token = generate_token(user)
    {
      'Authorization' => "Bearer #{token}"
    }
  end

  def generate_token(user)
    JWT.encode(
      { id: user.id, exp: 5.days.from_now.to_i, email: user.email },
      ENV['TOKEN_SECRET_KEY']
    )
  end
end
