class UserSerializer < ApplicationSerializer
  attributes :id, :email, :username

  attribute :created_date do |user|
    user.created_at && user.created_at.strftime('%m/%d/%Y')
  end
end
