class AuthSerializer < ApplicationSerializer
  attributes :id, :email, :username

  attribute :created_date do |user|
    user.created_at && user.created_at.strftime('%m/%d/%Y')
  end

  attribute :auth_token do |user|
    "Bearer #{user.auth_token}"
  end
end
